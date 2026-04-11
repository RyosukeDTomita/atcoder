module TakeDrop (take', take'', drop') where

take' :: Int -> [a] -> [a]
take' n _
  | n <= 0 = [] -- ガードにotherwiseをつけないことで条件不一致の時に下のパターンマッチへ進むようになっている。
take' _ [] = []
take' n (x : xs) = x : take' (n - 1) xs

-- https://hackage-content.haskell.org/package/ghc-internal-9.1401.0/docs/src/GHC.Internal.List.html#take
take'' :: Int -> [a] -> [a]
take'' n xs
  | 0 < n = unsafeTake n xs
  | otherwise = []

-- A version of take that takes the whole list if it's given an argument less
-- than 1.
{-# NOINLINE [0] unsafeTake #-} -- See Note [Inline FB functions]
unsafeTake :: Int -> [a] -> [a]
unsafeTake !_ [] = []
-- unsafeTake _ [] = [] -- これにするとundefinedが通るようになってしまう。
unsafeTake 1 (x : _) = [x]
unsafeTake m (x : xs) = x : unsafeTake (m - 1) xs

-- https://hackage-content.haskell.org/package/ghc-internal-9.1401.0/docs/src/GHC.Internal.List.html#drop
drop' :: Int -> [a] -> [a]
{-# INLINE drop' #-}
drop' n ls
  | n <= 0 = ls
  | otherwise = unsafeDrop n ls
  where
    -- A version of drop that drops the whole list if given an argument
    -- less than 1
    unsafeDrop :: Int -> [a] -> [a]
    unsafeDrop !_ [] = []
    unsafeDrop 1 (_ : xs) = xs
    unsafeDrop m (_ : xs) = unsafeDrop (m - 1) xs

main :: IO ()
main = do
  print $ take' 3 [0 ..]
  print $ take'' 3 [0 ..]
  -- print (unsafeTake undefined ([0 ..] :: [Int]))

  print $ drop' 3 [0 .. 10]
