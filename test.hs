import Data.List (foldl')

main :: IO ()
main = do
  -- print $ foldr (\x e -> if mod x 10==0 then 0 else (mod e 10)*x) 1 [1..10^7]
  print $ foldl' (\a e -> if mod e 10 == 0 then 0 else (mod e 10) * a) 1 [1 .. 10 ^ 7]
