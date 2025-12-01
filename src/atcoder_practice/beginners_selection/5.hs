import Control.Arrow ((>>>))

-- 500円玉、100円玉、50円玉それぞれが使用する可能性のある枚数は現在もっている枚数と(x `div` 通貨1枚の価値)の小さい方である。この全パターンを探索し、xになるものを探す。
solve :: [Int] -> Int
solve [a, b, c, x] =
  length
    [ (aN, bN, cN)
      | aN <- [0 .. (min (x `div` 500) a)],
        bN <- [0 .. (min (x `div` 100) b)],
        cN <- [0 .. (min (x `div` 50) c)],
        (aN * 500 + bN * 100 + cN * 50) == x
    ]

main :: IO ()
main =
  interact $
    lines >>> map read >>> solve >>> show >>> (++ "\n")
