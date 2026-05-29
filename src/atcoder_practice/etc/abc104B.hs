import Control.Arrow ((>>>))
import Data.Char (isUpper)

solve :: String -> String
solve (s0 : s1 : rest)
  | s0 /= 'A' = "WA" -- 先頭がAでない
  | isUpper s1 = "WA" -- 2文字目は大文字でない
  | otherwise = go rest False
  where
    -- 文字列 先頭から3文字目から末尾の2文字目までの間にcがちょうど1つあるか
    -- NOTE: interactは改行文字列\nを含むため、改行手前まで読めば終了する
    go ['\n'] isC = if isC then "AC" else "WA"
    go (c : rest) isC
      | not isC && c == 'C' =
          case rest of
            ['\n'] -> "WA" -- 末尾にCがあるのはNG
            _ -> go rest True
      | isC && c == 'C' = "WA" -- 大文字のCが2回以上登場するのはNG
      | isUpper c && c /= 'C' = "WA"
      | otherwise = go rest isC

main :: IO ()
main =
  interact $
    solve >>> (++ "\n")

-- main :: IO ()
-- main =
--   interact $ \input ->
--     solve input ++ "\n"
