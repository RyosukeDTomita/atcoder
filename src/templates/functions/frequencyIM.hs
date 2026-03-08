import Data.IntMap.Strict qualified as IM

frequency :: [Int] -> IM.IntMap Int
frequency xs =
  IM.fromListWith
    (+)
    [ (x, 1)
      | x <- xs
    ]

main :: IO ()
main = do
  print $ frequency [1, 2, 3, 1]
