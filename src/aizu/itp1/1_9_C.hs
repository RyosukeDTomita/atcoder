duel :: [Int] -> [String] -> [Int]
duel [taroPoint, hanakoPoint] [taroCard, hanakoCard]
  | taroCard > hanakoCard = [taroPoint + 3, hanakoPoint]
  | taroCard == hanakoCard = [taroPoint + 1, hanakoPoint + 1]
  | otherwise = [taroPoint, hanakoPoint + 3]

solve :: [[String]] -> [Int]
solve cards = foldl duel [0, 0] cards

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      -- _ = read (head ls) :: Int
      cards = map words $ tail ls
   in (unwords . map show $ solve cards) ++ "\n"