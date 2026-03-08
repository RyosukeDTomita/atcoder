-- 質問文が変更されたので修正 https://atcoder.jp/contests/abc433/clarifications 参照
import Data.List (elemIndex)
import Data.Maybe (fromJust)

solve :: [Int] -> String
solve as =
  let results =
        [ if isHigher as i then findNearIdx as i + 1 else -1
          | i <- [0 .. (length as - 1)]
        ]
   in unlines $ map show results

-- 自分より左側に自分よりも背が高い人がいるかを探す
isHigher :: [Int] -> Int -> Bool
isHigher as i = any (> (as !! i)) $ take i as

-- 自分よりも左側かつ、自分よりも身長が高い人の中で最も身長が近い人を選ぶNOTE: これは問題文が修正されたので修正が必要。
findNearIdx :: [Int] -> Int -> Int
findNearIdx as i =
  let a = as !! i
      tmp = last $ filter (> 0) $ map (subtract a) $ take i as
   in fromJust $ elemIndex (tmp + a) as

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      _ = read $ head ls :: Int
      as = map read . words $ ls !! 1 :: [Int]
   in solve as
