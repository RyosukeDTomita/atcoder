-- 通常のパターンマッチ
describeList :: [Int] -> String
describeList [] = "empty list"
describeList (x : rest) = "first element=" ++ show x ++ "all elements=" ++ show (x : rest) -- list全体の要素を表示する際にxとrestから再構成する必要がある。

-- asパターンを使うと分解前の値も使える
describeListAs :: [Int] -> String
describeListAs [] = "empty list"
-- describeListAs xlist@(x : rest) = -- restは使っていないので_スコアでマッチさせると良い(プレースホルダ)
describeListAs xlist@(x : _) =
  "first element=" ++ show x ++ "all elements=" ++ show xlist -- もとの値をそのままた受ける

main :: IO ()
main = do
  let testList = [1, 2, 3]
  print (describeList testList)
  print (describeListAs testList)
