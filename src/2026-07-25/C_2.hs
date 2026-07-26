{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

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

-- 順列が辞書順で何番目か(0-indexed)を求める。
-- 先頭から見て、まだ使っていない自分より小さい数の個数 * 残りの並べ方を足す。
lexRank :: Int -> [Int] -> Int
lexRank n xs = go xs (n - 1) -- ここで-1していることに注意
  where
    go :: [Int] -> Int -> Int
    go [] _ = 0
    go (x : rest) k = length (filter (< x) rest) * product [1 .. k] + go rest (k - 1)

solve :: Int -> [Int] -> [Int] -> Int
solve n ps qs = max 0 (qsN - psN - 1)
  where
    !psN = dbgId $ lexRank n ps
    !qsN = dbgId $ lexRank n qs

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        n = (read :: String -> Int) $ head ls
        ps = map read . words $ ls !! 1 :: [Int]
        qs = map read . words $ ls !! 2 :: [Int]
     in show (solve n ps qs) ++ "\n"
