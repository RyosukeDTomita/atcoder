-- 関数のパターンマッチを試す
describe :: Maybe String -> String
describe Nothing = "値がありません"
describe (Just s) = "値は " ++ s ++ " です"

main :: IO ()
main = do
  putStrLn (describe Nothing)
  putStrLn (describe (Just "Haskell"))
