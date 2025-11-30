-- solve :: Int -> [[Int]] ->
parse :: [String] -> [(Int, [[Int]])]
parse [] = []
parse
  (s : rest) =
    let [n, h] = map read . words $ s :: [Int]
        -- let [n, h] = map read (words s) :: [Int]
        tluList = map (map read . words) $ take n rest :: [[Int]]
     in (h, tluList) : parse (drop n rest)

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      t = read $ head ls :: Int
      caseList = tail ls :: [String]
   in show $ parse caseList
