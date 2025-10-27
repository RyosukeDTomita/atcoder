area' :: Integer -> Integer -> Integer
area' a b = a * b

perimeter :: Integer -> Integer -> Integer
perimeter a b = (2 * a) + (2 * b)

main :: IO ()
main = do
  let a = 2
  let b = 3
  putStrLn $ unwords . map show $ [area' a b, perimeter a b] -- Int配列を作ってshowで文字列にし、unwordsで空白区切りにして出力する。