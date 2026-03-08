{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}

-- {-# OPTIONS_GHC -DATCODER #-}
import Data.ByteString (ByteString)
import Data.ByteString.Char8 qualified as BS
-- import Control.Monad (State)

import Data.List (foldl')
import Data.Sequence (Seq, ViewL (..), (<|), (|>))
import Data.Sequence qualified as Seq
import Data.Vector.Unboxed qualified as VU
import Data.Vector.Unboxed.Mutable qualified as VUM
import Debug.Trace (traceShowId)

#ifdef ATCODER
debug :: Bool ; debug = False
#else
debug :: Bool ; debug = True
#endif

dbgId :: (Show a) => a -> a
dbgId x
  | debug = traceShowId x
  | otherwise = x

readInt :: BS.ByteString -> Int
readInt bs =
  case BS.readInt bs of
    Just (x, _) -> x
    Nothing -> error "input is not integer"

fst' :: ([Int], [Int], [Int]) -> [Int]
fst' (a, _, _) = a

snd' :: ([Int], [Int], [Int]) -> [Int]
snd' (_, b, _) = b

thd' :: ([Int], [Int], [Int]) -> [Int]
thd' (_, _, c) = c

solve :: [([Int], [Int], [Int])] -> [Int]
solve caseS = map go caseS
  where
    go :: ([Int], [Int], [Int]) -> Int
    go c =
      let ns = fst' c
          as = snd' c
          bs = thd' c
          n = head ns
          d = ns !! 1
       in simulate n d as bs

-- 卵の在庫管理を行う
-- ラングレス圧縮のように(仕入れた日付, 卵の数)のペアで管理する
-- ListやVectorの末尾連結はO(n)なのでData.Sequenceを採用し、O(1)で末尾連結している。
simulate :: Int -> Int -> [Int] -> [Int] -> Int
simulate n d as bs = sum (fmap snd stock)
  where
    stock = foldl' processDay Seq.empty (zip3 [1 .. n] as bs) -- zip3初めて使っているところ見たかも。
    -- (仕入れた日付, 卵の数)
    -- (経過日数, a, b)
    processDay :: Seq (Int, Int) -> (Int, Int, Int) -> Seq (Int, Int)
    processDay eggs (day, a, b) =
      -- 1. 仕入れ：(day, a) を追加
      let eggs1 = eggs |> (day, a)
          -- 2. 使用：bの卵を前から削除
          eggs2 = dropEggs b eggs1
          -- 3. 処分：D日以上経過した卵を削除
          eggs3 = Seq.dropWhileL (\(importDay, _) -> day - importDay >= d) eggs2 -- NOTE: ループしているため、最初に見つかった期限切れ卵の後ろには期限切れ卵はないため、走査を打ち切って良い。filterを使うとO(n)になるので注意。
       in eggs3

    -- リストから卵を前から引く(FIFO)
    dropEggs :: Int -> Seq (Int, Int) -> Seq (Int, Int)
    dropEggs 0 eggs = eggs
    dropEggs n eggs = case Seq.viewl eggs of
      EmptyL -> Seq.empty
      (day, cnt) :< rest
        | n >= cnt -> dropEggs (n - cnt) rest
        | otherwise -> (day, cnt - n) <| rest

parse :: [BS.ByteString] -> [([Int], [Int], [Int])]
parse [] = []
parse (ndByteS : asByteS : bsByteS : rest) =
  let [n, d] = map readInt . BS.words $ ndByteS :: [Int]
      as = map readInt . BS.words $ asByteS :: [Int]
      bs = map readInt . BS.words $ bsByteS :: [Int]
   in ([n, d], as, bs) : parse rest

main :: IO ()
main =
  BS.interact $ \inputs ->
    let ls = BS.lines inputs
        _ = readInt $ head ls -- T
        caseS = parse $ tail ls
     in BS.unlines (map (BS.pack . show) (solve caseS))
