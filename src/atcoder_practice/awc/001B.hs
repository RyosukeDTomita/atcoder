-- https://atcoder.jp/contests/awc0001/tasks/awc0001_b
-- {-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wunused-imports #-}

-- import Data.List (foldl1')
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

solve :: Int -> Int -> [Int] -> Int
solve l r ps = fst $ foldl' go (-1, l - 1) (zip [1 ..] ps :: [(Int, Int)])
  where
    go :: (Int, Int) -> (Int, Int) -> (Int, Int)
    go acc@(i, p) acc'@(i', p')
      | p' > p && p' <= r = acc' -- 同じ点数の場合は出席番号が若いほうが優先される
      | otherwise = acc

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        [n, l, r] = map read . words $ head ls :: [Int]
        ps = map read . words $ ls !! 1 :: [Int]
     in show (solve l r ps) ++ "\n"
