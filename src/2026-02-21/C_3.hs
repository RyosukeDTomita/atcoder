-- https://atcoder.jp/contests/abc446/submissions/73486031 を参考に作成
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}

-- {-# OPTIONS_GHC -DATCODER #-}

import Control.Monad.ST (runST)
import Data.ByteString (ByteString)
import Data.ByteString.Char8 qualified as BS
import Data.Function (fix)
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
    go c = runST $ do
      let ns = fst' c
          as = snd' c
          bs = thd' c
          n = head ns
          d = ns !! 1

      xs <- VU.thaw (VU.fromList as) -- NOTE: thawでミュータブルに変更
      let ys = VU.fromList bs

      -- 配列を使い、卵の個数を表している。[1日目に共有された卵の個数, 2日目に供給された卵の個数...]
      lastIFrom <-
        VU.ifoldM'
          ( \iFrom0 i y0 -> do
              iFrom' <- flip fix (iFrom0, y0) $ \loop (!iFrom, !y) -> do
                if y == 0
                  then pure iFrom
                  else do
                    x <- VUM.read xs iFrom -- xsのiForm番目の値を取得
                    -- 卵を使用する
                    if x <= y
                      then do
                        VUM.write xs iFrom 0
                        loop (iFrom + 1, y - x)
                      else do
                        VUM.modify xs (subtract y) iFrom -- xsのiForm番目の値から-y
                        pure iFrom -- iFormには0以上の値の入っている
              pure $ max (i + 1 - d) iFrom' -- i+1は現在の日付なのでi+1-dは卵を全く使わなかった際に捨てられるindexの場所を指す。e.g. d=2の時に3日目に1日目に追加された卵を処分する。
          )
          (0 :: Int)
          ys

      xsFrozen <- VU.freeze xs
      pure $ VU.sum (VU.drop lastIFrom xsFrozen) -- 最終日に毎回

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
