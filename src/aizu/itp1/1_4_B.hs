import Text.Printf (printf)

area :: Double -> Double
area r = r * r * pi

circumference :: Double -> Double
circumference r = 2 * pi * r

main :: IO ()
main = do
  r <- readLn :: IO Double -- 小数点ありと無しが混ざっている場合でもいける
  printf "%.6f %.6f\n" (area r) (circumference r)
