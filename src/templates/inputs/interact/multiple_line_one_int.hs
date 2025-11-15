import Control.Arrow ((>>>))

-- >>> 版（左から右）
main :: IO ()
main =
  interact $
    lines >>> map (read :: String -> Int) >>> show >>> (++ "\n")

-- . 版（右から左）
-- main = interact $ (++ "\n") . show . map (read :: String -> Int) . lines
