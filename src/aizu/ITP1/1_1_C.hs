import Text.XHtml (area)

area' :: Int -> Int -> Int
area' a b = a * b

perimeter :: Int -> Int -> Int
perimeter a b = (2 * a) + (2 * b)

main :: IO ()
main = do
  [a, b] <- map read . words <$> getLine :: IO [Int]
  putStrLn . unwords . map show $ [area' a b, perimeter a b] -- Int配列を作ってshowで文字列にし、unwordsで空白区切りにして出力する。
  -- (putStrLn . unwords . map show) [area' a b, perimeter a b] -- このように書いても良い
  -- putStrLn . unwords . map show [area a b, perimeter a b] と書くとただ関数を結合させただけで動かない。
