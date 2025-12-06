import Data.List (intercalate)

main :: IO ()
main = do
  let name = ["Taro", "Hanako"]
  print $ intercalate ", " name -- "Taro, Hanako"