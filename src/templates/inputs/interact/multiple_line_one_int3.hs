-- 終了文字列(0)が存在する場合の複数行input (interact版)
main :: IO ()
main = interact $ \input ->
  let ls = map read . lines $ input :: [Int]
      intList = takeWhile (/= 0) ls -- 終了文字列0までnumbersから値を取得する
   in show intList ++ "\n"
