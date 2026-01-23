-- TLEになった
{-# LANGUAGE CPP #-}

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

mergeSort :: [Int] -> (Int, [Int])
mergeSort [] = (0, [])
mergeSort [x] = (0, [x])
mergeSort xs =
  let (left, right) = splitAt (length xs `div` 2) xs
      (i, leftSorted) = mergeSort left
      (j, rightSorted) = mergeSort right
      (k, merged) = merge (i, leftSorted) (j, rightSorted)
   in (i + j + k, merged)

-- マージしながら反転数をカウント
merge :: (Int, [Int]) -> (Int, [Int]) -> (Int, [Int])
merge (_, []) (j, ys) = (0, ys)
merge (i, xs) (_, []) = (0, xs)
merge (i, x : xs) (j, y : ys)
  | x <= y =
      let (cnt, rest) = merge (i, xs) (j, y : ys)
       in (cnt, x : rest)
  | otherwise =
      let (cnt, rest) = merge (i, x : xs) (j, ys)
       in -- 右側の要素を選ぶとき、左側の残り要素数(1 + length xs)分の反転が発生
          (cnt + 1 + length xs, y : rest) -- NOTE: xも含むので+1している

solve :: [Int] -> Int
solve as = fst $ mergeSort as

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        -- n = (read :: String -> Int) $ head ls
        as = map read . words $ ls !! 1 :: [Int]
     in show (solve as) ++ "\n"