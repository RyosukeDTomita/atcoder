import Data.List (isSubsequenceOf, permutations, subsequences)

main :: IO ()
main = do
  print $ subsequences "abc" -- ["","a","b","ab","c","ac","bc","abc"

  -- isSubSequenceOfを使い、全て部分列であることを確認する
  print $ all (`isSubsequenceOf` "abc") (subsequences "abc")

  -- 並び替えのパターン
  print $ permutations "abc" -- ["abc","bac","cba","bca","cab","acb"]
