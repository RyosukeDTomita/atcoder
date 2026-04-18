{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wunused-imports #-}

-- import Data.List (sort)
import Data.Set qualified as Set
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

eraseDuplicate :: (Ord a) => [a] -> [a]
eraseDuplicate xs = (Set.toList . Set.fromList) xs

-- 全員が別々の服を着ているか
question1 :: Int -> [Int] -> String
question1 n fs = if n == length (eraseDuplicate fs) then "Yes" else "No"

question2 :: Int -> [Int] -> String
question2 m fs =
  let s = eraseDuplicate fs
   in -- sSorted = sort s
      if length s == m then "Yes" else "No"

solve :: Int -> Int -> [Int] -> [String]
solve n m fs =
  let result1 = question1 n fs
      result2 = question2 m fs
   in result1 : [result2]

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        ![n, m] = map read . words $ head ls :: [Int] -- [人数, 服の種類]
        !fs = map read . words $ ls !! 1 :: [Int] -- 着ている服の種類
     in unlines $ solve n m fs
