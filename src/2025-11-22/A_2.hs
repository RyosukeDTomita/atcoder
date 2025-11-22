import Control.Arrow ((>>>))

-- z >= 2なので z = 1 かつ x = 1 かつ y = 1の場合は考えなくてよい
solve :: [Int] -> String
solve [x, y, z] =
  -- x + n = (y + n) * zをみたすnが存在するかを考える。
  -- n = yz + nz - x
  -- n(1 - z) = yz - x
  -- n = (yz - x) / (1 - z)
  let num = y * z - x
      n = (y * z - x) `div` (1 - z)
   in if num `mod` (1 - z) == 0 && n >= 0 -- NOTE: modが0のためdivを使っても結果が丸められることはない
        then "Yes"
        else "No"

main :: IO ()
main =
  interact $
    words
      >>> map (read :: String -> Int)
      >>> solve
      >>> (++ "\n")
