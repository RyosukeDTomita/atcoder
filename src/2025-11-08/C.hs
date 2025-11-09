-- TLEになったバージョン
import Data.List (sort)

--
check :: [Int] -> [Int] -> Int -> Bool
-- check :: [Int] -> [Int] -> Int -> Int
check bList hList k =
  let validCombinations =
        [ filter (>= 0) $ map (\b -> b - h) bList
          | n <- [0 .. k - 1],
            let h = hList !! n
        ]
      -- 空でないリストの個数を数える
      numRobots = length $ filter (not . null) validCombinations
   in numRobots >= k

main :: IO ()
main = do
  [n, m, k] <- map read . words <$> getLine :: IO [Int] -- 頭パーツの数,体パーツの数、作りたいロボットの数
  hList <- sort . map read . words <$> getLine :: IO [Int] -- 頭パーツの重さ
  bList <- map read . words <$> getLine :: IO [Int] -- 体パーツの重さ
  let result = check bList hList k
  -- print result

  if result
    then
      putStrLn "Yes"
    else putStrLn "No"