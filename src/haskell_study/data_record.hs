-- RGBA型をレコード構文で定義
data RGBA = RGBA
  { getR :: Float,
    getG :: Float,
    getB :: Float,
    getA :: Float
  }
  deriving (Show, Eq)

main :: IO ()
main = do
  let red = RGBA {getR = 1.0, getG = 0.0, getB = 0.0, getA = 1.0}
  print red
  print (getR red)