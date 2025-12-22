import Data.List (foldl', maximumBy)
import Data.Set qualified as Set

-- Set.memberを使ってbsが1行単位に分割したasにいくつ含まれているか調べる
solve :: [[Int]] -> [Int] -> Int
solve ass bs =
  let bsSet = Set.fromList bs
   in maximum $ map (length . filter (`Set.member` bsSet)) ass

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      [h, w, n] = map read . words $ head ls :: [Int]
      ass = map (map read . words) $ take h $ tail ls :: [[Int]]
      bs = map read $ drop h $ tail ls :: [Int]
   in show (solve ass bs) ++ "\n"