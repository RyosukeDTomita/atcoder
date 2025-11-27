import Data.List (isInfixOf, isPrefixOf, isSubsequenceOf, isSuffixOf)

main :: IO ()
main = do
  -- isPrefixOfは前方一致
  print $ isPrefixOf "dream" "dreameraser" -- True
  print $ isPrefixOf "erase" "dreameraser" -- False
  -- isSuffixOfは後方一致
  print $ isSuffixOf "dream" "dreameraser" -- False
  print $ isSuffixOf "erase" "dreameraser" -- False
  print $ isSuffixOf "eraser" "dreameraser" -- False
  -- isInfixOfはどこかにあれば良い
  print $ isInfixOf "dream" "dreameeraser" -- True
  print $ isInfixOf "eam" "dreameeraser" -- True
  print $ isInfixOf "erd" "dreameeraser" -- False
  -- isSubsequenceOfは部分列かどうかをチェックする
  -- NOTE: 部分列であるとは配列aの順序を保ったまま、間に要素が入っても全ての要素が含まれている状態。e.g. abcはaxbycの部分列
  print $ isSubsequenceOf "dea" "dreameeraser" -- True
  print $ isSubsequenceOf "rd" "dreameeraser" -- False