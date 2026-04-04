-- module TakeDrop (take', drop') where

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
-- unsafeTake _ [] = []
unsafeTake 1 (x : _) = [x]
unsafeTake m (x : xs) = x : unsafeTake (m - 1) xs

-- drop':: Int -> [a] -> [a]

main :: IO ()
main = do
  print $ take' 3 [0 ..]
  print $ take'' 3 [0 ..]
  -- print $ unsafeTake undefined [] -- []はprintに渡したことで、戻り値のリスト要素型 a が決まらずに曖昧になっている。
  print (unsafeTake undefined ([] :: [Int]))
