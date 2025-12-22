module Iterate (iterate') where

iterate' :: (a -> a) -> a -> [a]
iterate' f x = x : iterate f (f x)

main :: IO ()
main = do
  print $ take 5 $ iterate' (subtract 100) 1000 -- [1000,900,800,700,600]
  print $ takeWhile (>= 0) $ iterate' (subtract 100) 1000 -- [1000,900,800,700,600,500,400,300,200,100,0]