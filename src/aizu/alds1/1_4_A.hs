import Data.Set qualified as Set

-- import qualified Data.Set as Set -- AOJならこっち

solve :: [Int] -> [Int] -> Int
-- solve s t = length $ filter (`elem` t) s -- 重複が残るのでだめそう
solve s t =
  let s' = Set.toList $ Set.fromList s
   in length $ filter (`Set.member` Set.fromList t) s'

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        -- n = (read :: String -> Int) $ head ls
        s = map read . words $ ls !! 1 :: [Int]
        -- q = (read :: String -> Int) $ ls !! 2
        t = map read . words $ ls !! 3
     in show (solve s t) ++ "\n"