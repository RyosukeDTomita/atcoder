import Data.Map qualified as Map
import Text.Printf (printf)

solve :: [(Int, Int)] -> Int -> [Double]
solve abTuple m =
  let groupBird =
        groupValues abTuple
   in averageValues groupBird m

-- Aの値が等しい=同じ種類の鳥の重さBのデータを集める
groupValues :: [(Int, Int)] -> Map.Map Int [Int]
groupValues =
  foldl
    (\m (k, v) -> Map.insertWith (++) k [v] m)
    Map.empty

averageValues :: Map.Map Int [Int] -> Int -> [Double]
averageValues groups m =
  let groupsList = Map.toList groups
   in [ case Map.lookup k groups of
          Just values -> fromIntegral (sum values) / fromIntegral (length values)
          Nothing -> 0.0
        | k <- [1 .. m]
      ]

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      [_, m] = map read . words $ head ls :: [Int]
      abTuple =
        [ (a, b)
          | line <- drop 1 ls,
            let [a, b] = map read (words line) :: [Int]
        ]
   in unlines $ map (printf "%.20f") $ solve abTuple m
