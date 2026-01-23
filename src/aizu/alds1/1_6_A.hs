-- Memory Limit Exceed
import Data.Array (accumArray, assocs)

-- accumArray
--  :: GHC.Ix.Ix i =>
--     (e -> a -> e) -> e -> (i, i) -> [(i, a)] -> GHC.Arr.Array i e
-- ghci> accumArray (+) 0 (0,5) [(x, 1) | x <- [1,1,2,3,5]]
-- array (0,5) [(0,0),(1,2),(2,1),(3,1),(4,0),(5,1)]
countingSort :: [Int] -> [Int]
countingSort [] = []
countingSort xs =
  let maxX = maximum xs
      minX = minimum xs
      range = (minX, maxX)
      -- 各値の出現回数をカウント（配列を使用してO(n)）
      counts = accumArray (+) 0 range [(x, 1) | x <- xs]
      -- カウント配列から元のリストを再構築
      expand (i, count) = replicate count i
   in concatMap expand (assocs counts)

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        -- n = (read :: String -> Int) $ head ls
        xs = map read . words $ ls !! 1 :: [Int]
     in unwords (map show (countingSort xs)) ++ "\n"