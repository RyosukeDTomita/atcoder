import Data.Maybe

toMaybeBool :: String -> Maybe Bool
toMaybeBool s
  | s == "True" = Just True
  | s == "False" = Just False
  | otherwise = Nothing

main :: IO ()
main = do
  let result1 = toMaybeBool "True"
  print result1
  let result2 = toMaybeBool "False"
  print result2
  let result3 = toMaybeBool "hoge"
  print result3
  -- isJustを使ってみる。Justかどうかだけを見て審議判定をしている。
  print (isJust result1)
  print (isJust result2)
  print (isJust result3)
