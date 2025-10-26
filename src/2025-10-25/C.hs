import Control.Monad (when)
import Data.List (foldl')
import Data.Map qualified as Map
import System.Exit (exitSuccess)

countNum :: [Integer] -> Map.Map Integer Integer
countNum iList = foldl' (\mapI i -> Map.insertWith (+) i 1 mapI) Map.empty iList

findDuplicateNum :: Map.Map Integer Integer -> [(Integer, Integer)]
findDuplicateNum countNumMap = filter (\(_, count) -> count >= 2) $ Map.toList countNumMap

nCr :: Integer -> Integer -> Integer
-- nCr n r = foldl (*) 1 [n - r + 1 .. n] `div` foldl (*) 1 [1 .. r]
nCr n r = product [n - r + 1 .. n] `div` product [1 .. r]

main :: IO ()
main = do
  n <- readLn :: IO Integer
  aList <- map read . words <$> getLine :: IO [Integer]
  -- print aList
  -- どの数が何回でてきたかのmapを作る
  let countNumMap = countNum aList
  -- print countNumMap

  when (length countNumMap == 1) $ do
    print 0
    exitSuccess

  -- 2回以上出現しているリストだけをfilter
  let duplicateList = findDuplicateNum countNumMap
  -- print duplicateList

  -- nCrを使い、2個以上存在する数の選び方の全通りを計算し、残りの数からパターンを算出する
  -- print $ sum (map (\x -> (x `nCr` 2) * (n - x)) (map snd duplicateList))
  print $ sum (map ((\x -> (x `nCr` 2) * (n - x)) . snd) duplicateList)
