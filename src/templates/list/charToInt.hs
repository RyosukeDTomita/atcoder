import Data.Char (digitToInt, intToDigit)

main :: IO ()
main = do
  print $ map digitToInt "123" -- [1,2,3] CharをIntに変換する
  print $ map intToDigit [1, 2, 3]
  print $ toInteger 123 -- 既に数値になっているものをIntegerに変換する。Charなどは変換できないので注意