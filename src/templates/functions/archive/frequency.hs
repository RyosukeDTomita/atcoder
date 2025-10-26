-- 型ごとに書いていたバージョン
import Data.List (foldl') -- foldlよりもfoldl'の方が積極評価のためパフォーマンスが良い
import Data.Map qualified as Map

charFrequency :: String -> Map.Map Char Int
charFrequency s = foldl' (\m c -> Map.insertWith (+) c 1 m) Map.empty s

intFrequency :: [Int] -> Map.Map Int Int
intFrequency iList = foldl' (\m c -> Map.insertWith (+) c 1 m) Map.empty iList

main :: IO ()
main = do
  let word = "aaabbc"
  let charFreqMap = charFrequency word -- fromList [('a',3),('b',2),('c',1)]
  print charFreqMap

  -- 2回以上出現している文字を探して出力する
  let charDuplicateMap = filter (\(c, n) -> n >= 2) $ Map.toList charFreqMap
  -- print charDuplicateMap
  putStrLn $ map fst charDuplicateMap

  let iList = [0, 1, 1, 2, 3, 5]
  print $ intFrequency iList -- fromList [(0,1),(1,2),(2,1),(3,1),(5,1)]