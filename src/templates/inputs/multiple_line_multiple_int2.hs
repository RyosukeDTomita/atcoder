import Control.Monad (replicateM)

-- 冒頭で行の数が示されている場合の二次元のinput
main :: IO ()
main = do
  [h, _] <- map read . words <$> getLine
  intList <- replicateM h $ map read . words <$> getLine :: IO [[Int]]
  print intList
