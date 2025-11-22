import Data.List (elemIndex)
import Data.Maybe (fromJust)

solve :: [Int] -> String
-- solve as = unlines $ map show $ map (findNearestLeft as) [0 .. length as - 1]
solve as = unlines $ map (show . findNearestLeft as) [0 .. length as - 1]

-- idx 番目の人の左側で、身長が自分より高い人の中で最も近い人の番号を返す。
findNearestLeft :: [Int] -> Int -> Int
findNearestLeft as idx = go (idx - 1)
  where
    a = as !! idx -- 自分の身長
    go (-1) = -1 -- 左側にいない場合
    go i
      | as !! i > a = i + 1 -- 1-indexed
      | otherwise = go (i - 1) -- 左から右に調査する

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      _ = read $ head ls :: Int
      as = map read . words $ ls !! 1 :: [Int]
   in solve as
