module TakeWhile (takeWhile') where

takeWhile' :: (a -> Bool) -> [a] -> [a]
takeWhile' _ [] = []
takeWhile' f (x : xs)
  | f x = x : takeWhile' f xs
  | otherwise = []

main :: IO ()
main = do
  print $ takeWhile' (>= 0) $ iterate (subtract 100) 1000 -- [1000,900,800,700,600,500,400,300,200,100,0]