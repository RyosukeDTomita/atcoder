-- https://atcoder.jp/contests/typical90/tasks/typical90_bc
-- combinationsで5要素リストを実体化する版。ギリギリAC(4994ms)。
-- 高速版(途中積持ち回り)は055.hsを参照。
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.ByteString.Char8 qualified as BS
import Data.List (foldl')
import Debug.Trace (traceShowId)

-- {-# OPTIONS_GHC -DATCODER #-}
#ifdef ATCODER
debug :: Bool ; debug = False
#else
debug :: Bool ; debug = True
#endif

dbgId :: (Show a) => a -> a
dbgId x
  | debug = traceShowId x
  | otherwise = x

-- | 組み合わせ(nCk)
-- n個のリストからk個を選ぶが、選んだ後の順序は問わない。
combinations :: Int -> [a] -> [[a]]
combinations 0 _ = [[]] -- k個選び終えたら空列を1つ返す
combinations _ [] = [] -- まだ選ぶ必要があるのに候補が尽きたら打ち切り k > nの時は0なので[]を返している。
combinations k (x : xs) =
  -- 先頭xを「選ぶ」場合と「選ばない」場合に分ける
  map (x :) (combinations (k - 1) xs) -- xを選び、残りからk-1個
    ++ combinations k xs -- xを選ばず、残りからk個

solve :: Int -> Int -> [Int] -> Int
solve p q as = foldl' go 0 $ combinations 5 as
  where
    go :: Int -> [Int] -> Int
    go acc xs
      | prodMod xs == q = acc + 1
      | otherwise = acc
    -- Aiは最大10^9、5個の積は最大10^45でInt(64bit)を溢れる。
    -- 掛けるたびにmod pを取って桁溢れを防ぐ。
    prodMod :: [Int] -> Int
    prodMod ys = foldl' (\a y -> a * y `mod` p) 1 ys

readInt :: BS.ByteString -> Int
readInt bs = case BS.readInt bs of
  Just (x, _) -> x
  Nothing -> error "input is not integer"

main :: IO ()
main =
  BS.interact $ \inputs ->
    let ls = BS.lines inputs
        [n, p, q] = map readInt . BS.words $ head ls :: [Int]
        as = map readInt . BS.words $ ls !! 1 :: [Int]
     in (BS.pack . show) (solve p q as) <> BS.pack "\n"
