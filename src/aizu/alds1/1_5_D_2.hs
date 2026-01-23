-- lengthを使うと都度O(n)なので配列の長さを引き回すように変更する
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

-- Return: (反点数, 配列の長さ, 分割した配列)
mergeSort :: [Int] -> (Int, Int, [Int])
mergeSort [] = (0, 0, [])
mergeSort [x] = (0, 1, [x])
mergeSort xs =
  let (left, right) = splitAt (length xs `div` 2) xs
      (i, l, leftSorted) = mergeSort left
      (j, r, rightSorted) = mergeSort right
      (k, merged) = merge l leftSorted rightSorted
   in (i + j + k, l + r, merged)

-- マージしながら反転数をカウント
merge :: Int -> [Int] -> [Int] -> (Int, [Int])
merge _ [] ys = (0, ys)
merge _ xs [] = (0, xs)
merge l (x : xs) (y : ys)
  | x <= y =
      let (cnt, rest) = merge (l - 1) xs (y : ys)
       in (cnt, x : rest)
  | otherwise =
      let (cnt, rest) = merge l (x : xs) ys
       in -- 右側の要素を選ぶとき、左側の残り要素数(l)分の反転が発生
          (cnt + l, y : rest)

solve :: [Int] -> Int
solve as = let (inv, _, _) = mergeSort as in inv

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        -- n = (read :: String -> Int) $ head ls
        as = map read . words $ ls !! 1 :: [Int]
     in show (solve as) ++ "\n"