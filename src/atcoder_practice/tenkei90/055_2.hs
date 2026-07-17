-- https://atcoder.jp/contests/typical90/tasks/typical90_bc
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}
import Debug.Trace (traceShowId)
import Data.ByteString.Char8 qualified as BS

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


-- combinationsと同じ「選ぶ/選ばない」の再帰だが、5要素リストを実体化せず途中積accを持ち回る。
-- C(100,5)=約7500万通りのリスト生成が消えるぶん速い(実測4.9s→1.5s)。
-- Aiは最大10^9で5個の積はInt(64bit)を溢れるため、先にmod pへ落とし掛けるたびにmod pを取る。
solve :: Int -> Int -> [Int] -> Int
solve p q as = go 5 1 $ map (`mod` p) as
  where
    go :: Int -> Int -> [Int] -> Int
    go 0 !acc _ = if acc == q then 1 else 0 -- 5個選び終えたら余りを判定
    go _ _ [] = 0 -- まだ選ぶ必要があるのに候補が尽きたら打ち切り
    go k !acc (x : xs) =
      -- 先頭xを「選ぶ」場合と「選ばない」場合に分ける
      go (k - 1) (acc * x `mod` p) xs -- xを選び、積に反映して残りからk-1個
        + go k acc xs -- xを選ばず、残りからk個

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
