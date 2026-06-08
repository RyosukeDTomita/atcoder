import Data.List (isSubsequenceOf, permutations, subsequences, tails)

main :: IO ()
main = do
  print $ subsequences "abc" -- ["","a","b","ab","c","ac","bc","abc"

  -- isSubSequenceOfを使い、全て部分列であることを確認する
  print $ all (`isSubsequenceOf` "abc") (subsequences "abc")

  -- 並び替えのパターン
  print $ permutations "abc" -- ["abc","bac","cba","bca","cab","acb"]

  -- 部分列は問題によっては、こういう定義だったりもする
  print $ tails "ZABCDBABCQ" -- ["ZABCDBABCQ","ABCDBABCQ","BCDBABCQ","CDBABCQ","DBABCQ","BABCQ","ABCQ","BCQ","CQ","Q",""]
  print $ filter ((== "ABC") . take 3) $ tails "ZABCDBABCQ"
