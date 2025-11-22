import Control.Arrow ((>>>))

-- >>> 版（左から右）
main :: IO ()
main =
  interact $
    lines >>> map (read :: String -> Int) >>> map show >>> unlines

-- . 版（右から左）
-- main = interact $ unlines . map show . map (read :: String -> Int) . lines
