import Data.List (isSubsequenceOf, permutations, subsequences, tails)

main :: IO ()
main = do
-- NOTE: `subsequences`が使えるのは元の文字列から0個以上の要素を消して、残りの順序を保ったまま並べたものである。
  print $ subsequences "abc" -- ["","a","b","ab","c","ac","bc","abc"

  -- isSubSequenceOfを使い、全て部分列であることを確認する
  print $ all (`isSubsequenceOf` "abc") (subsequences "abc"u

  -- 並び替えのパターン
  print $ permutations "abc" -- ["abc","bac","cba","bca","cab","acb"]

  -- 部分列は問題によっては、先頭から削っていくパターンを部分列と呼ぶこともある。abc150bなど
  print $ tails "ZABCDBABCQ" -- ["ZABCDBABCQ","ABCDBABCQ","BCDBABCQ","CDBABCQ","DBABCQ","BABCQ","ABCQ","BCQ","CQ","Q",""]
  print $ filter ((== "ABC") . take 3) $ tails "ZABCDBABCQ"
