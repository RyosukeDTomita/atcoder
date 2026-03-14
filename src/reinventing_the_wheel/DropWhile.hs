module DropWhile (dropWhile', dropWhileEnd', dropWhileEnd'') where

import Data.List (dropWhileEnd)

dropWhile' :: (a -> Bool) -> [a] -> [a]
dropWhile' _ [] = []
dropWhile' f (x : xs)
  | f x = dropWhile' f xs -- Trueなら捨てる
  | otherwise = x : xs -- falseが出たらそこから残りを返す

-- 末尾からTrueのものを消す。
dropWhileEnd' :: (a -> Bool) -> [a] -> [a]
dropWhileEnd' f xs = reverse . dropWhile f . reverse $ xs

-- foldrバージョン
dropWhileEnd'' :: (a -> Bool) -> [a] -> [a]
dropWhileEnd'' f xs = fst . foldr step ([], True) $ xs
  where
    step x (acc, dropping)
      | dropping && f x = (acc, True)
      | otherwise = (x : acc, False) -- Falseがでたら止まる。

main :: IO ()
main = do
  print $ dropWhile (<= 0) $ take 20 $ iterate (+ 100) (-1000)
  print $ dropWhile' (<= 0) $ take 20 $ iterate (+ 100) (-1000)

  print $ dropWhileEnd (== 0) [1, 2, 0, 3, 0, 0, 0] -- [1,2,0,3]
  print $ dropWhileEnd' (== 0) [1, 2, 0, 3, 0, 0, 0]
  print $ dropWhileEnd'' (== 0) [1, 2, 0, 3, 0, 0, 0]
