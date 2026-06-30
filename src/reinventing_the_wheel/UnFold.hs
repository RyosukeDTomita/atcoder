{-# LANGUAGE ScopedTypeVariables #-}

module Unfoldr (unfoldr') where

unfoldr' :: forall a b. (b -> Maybe (a, b)) -> b -> [a]
unfoldr' f b0 = go b0
  where
    go :: b -> [a]
    go b = case f b of
      Just (a, new_b) -> a : go new_b
      Nothing -> []

main :: IO ()
main = do
  print $ unfoldr' (\b -> if b == 0 then Nothing else Just (b, b - 1)) 10
