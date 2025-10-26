import Data.List (foldl') -- foldlよりもfoldl'の方が積極評価のためパフォーマンスが良い
import Data.Map qualified as Map

-- 汎用的な頻度カウント関数（Ordならどんな型でもOK）
frequency :: (Ord a) => [a] -> Map.Map a Int
frequency a = foldl' (\m c -> Map.insertWith (+) c 1 m) Map.empty a

-- ghci> Map.insertWith (+) 'a' 1 Map.empty
-- fromList [('a',1)]
-- ghci> Map.insertWith (+) 'a' 1 (Map.fromList [('a', 1)])
-- fromList [('a',2)]

main :: IO ()
main = do
  let word = "aaabbc"
  let charFreqMap = frequency word -- fromList [('a',3),('b',2),('c',1)]
  print charFreqMap
  -- print $ Map.toList charFreqMap

  -- 2回以上出現している文字を探して出力する
  let charDuplicateMap = filter (\(_, n) -> n >= 2) $ Map.toList charFreqMap -- Mapのままだとfilterやmapが使えないのでlistに変換してから処理している。
  putStrLn $ map fst charDuplicateMap
  -- 2回以上出現した文字の総数を求める
  print $ sum $ map snd charDuplicateMap

  -- 他の型でも使える例
  let iList = [0, 1, 1, 2, 3, 5]
  print $ frequency iList -- fromList [(0,1),(1,2),(2,1),(3,1),(5,1)]
  let wordList = ["apple", "banana", "apple", "cherry", "banana", "apple"]
  print $ frequency wordList -- fromList [("apple",3),("banana",2),("cherry",1)]