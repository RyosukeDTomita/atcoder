import Control.Monad

pickAndSum :: Int -> [Int] -> [Int]
pickAndSum 0 _ = []
pickAndSum i aList =
  let currentSum = sum (take (i - 1) aList ++ drop i aList)
   in currentSum : pickAndSum (i - 1) aList

main :: IO ()
main = do
  [n, m] <- map read . words <$> getLine :: IO [Int]
  aList <- map read . words <$> getLine :: IO [Int]
  if m `elem` pickAndSum n aList
    then putStrLn "Yes"
    else putStrLn "No"