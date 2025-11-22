import Data.Char (digitToInt)

main :: IO ()
main = do
  print $ map digitToInt "123" -- [1,2,3] CharをIntに変換する
  print $ toInteger 123 -- 既に数値になっているものをIntegerに変換する。Charなどは変換できないので注意