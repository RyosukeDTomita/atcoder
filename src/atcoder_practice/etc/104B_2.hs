import Control.Arrow ((>>>))
import Data.Char (isUpper)

solve :: String -> String
solve [] = "WA"
solve [_] = "WA"
solve (s0 : s1 : rest)
  | s0 /= 'A' = "WA" -- 先頭がAでない
  | isUpper s1 = "WA" -- 2文字目は大文字でない
  | otherwise = go rest False
  where
    -- go 文字列 Cがすでに登場したか
    go [] isC = if isC then "AC" else "WA"
    go (c : rest) isC
      | not isC && c == 'C' =
          case rest of
            [] -> "WA" -- 末尾がCはNG
            _ -> go rest True
      | isC && c == 'C' = "WA" -- 大文字のCが2回以上登場するのはNG
      | isUpper c && c /= 'C' = "WA"
      | otherwise = go rest isC

-- main :: IO ()
-- main =
--   interact $ \input ->
--     let !s = takeWhile (/= '\n') input -- 正格評価にしたら早くなった
--     -- let s = takeWhile (/= '\n') input
--      in solve s ++ "\n"

main :: IO ()
main = do
  s <- getLine
  -- !s <- getLine
  putStrLn $ solve s