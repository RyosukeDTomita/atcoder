module Transpose (transpose') where

transpose' :: [[a]] -> [[a]]
transpose' ([] : _) = [] -- リストの最初の要素が[]の場合[[], [1]]
transpose' xs = map head xs : transpose' (map tail xs) -- map head xsで全ての冒頭要素を取り出し、連結する
-- e.g. transpose' [[1, 2, 3], [4, 5, 6], [7, 8, 9]]の場合
-- = map head [[1, 2, 3], [4, 5, 6], [7, 8, 9]] : transpose' (map tail [[1, 2, 3], [4, 5, 6], [7, 8, 9]])
-- = [1, 4, 7] : transpose' (map tail [[1, 2, 3], [4, 5, 6], [7, 8, 9]])
-- = [1, 4, 7] : transpose' [[2, 3], [5, 6], [8, 9]]
-- = [1, 4, 7] : map head [[2, 3], [5, 6], [8, 9]] : transpose' (map tail [[2, 3], [5, 6], [8, 9]]
-- = [1, 4, 7] : [2, 5, 8] : transpose' (map tail [[2, 3], [5, 6], [8, 9]]
-- = [1, 4, 7] : [2, 5, 8] : transpose' [[3], [6], [9]]
-- = [1, 4, 7] : [2, 5, 8] : map head [[3], [6], [9]] : transpose' (map tail [3], [6], [9]])
-- = [1, 4, 7] : [2, 5, 8] : [3, 6, 9] : transpose' (map tail [3], [6], [9]])
-- = [1, 4, 7] : [2, 5, 8] : [3, 6, 9] : transpose' [[], [], []]
-- = [1, 4, 7] : [2, 5, 8] : [3, 6, 9] : []
-- = [[1, 4, 7], [2, 5, 8], [3, 6, 9]]

main :: IO ()
main = do
  print $ transpose' [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
  print $ transpose' [["One", "Two", "Three"], ["Four", "Five", "Six"], ["Seven", "Eight", "Nine"]]