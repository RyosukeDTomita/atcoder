-- ChatGPTに作ってもらったストリーミングを使わないシンプルな実装
import Data.Char (isLower)

solve :: String -> String
solve s
  | head s /= 'A' = "WA"
  | otherwise =
      let mid = drop 2 (take (length s - 1) s) -- 3文字目〜末尾-1
       in case filter (== 'C') mid of
            [_] | all isLower (filter (/= 'C') (tail s)) -> "AC"
            _ -> "WA"

main :: IO ()
main = do
  s <- getLine
  putStrLn (solve s)
