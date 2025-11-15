import Data.Char (digitToInt) -- sumDigits'で使用

solve :: Int -> Int -> Int -> Int
solve n a b =
  sum
    [ i
      | i <- [0 .. n],
        let s = sumDigits i, -- 内包表記の中でのletにinは不要
        -- let s = sumDigits' i,
        a <= s && s <= b
    ]

-- 各桁の数の和を求める。
-- e.g. 123の場合
-- sumDigits 123
-- = (123 `mod` 10) + sumDigits (123 `div` 10)
-- = 3 + sumDigits 12
-- = 3 + (12 `mod` 10) + sumDigits (12 `div` 10)
-- = 3 + 2 + sumDigits 1
-- = 6
sumDigits :: Int -> Int
sumDigits i
  | i < 10 = i
  | otherwise = (i `mod` 10) + sumDigits (i `div` 10)

-- ChatGPTに教えれもらったより簡潔な実装。一度[Char]にしてそれを1つずつ数値として取り出し、和を求める。
-- ghci > (map digitToInt . show) 123
-- [1, 2, 3]
-- ghci> (sum . map digitToInt . show) 123
-- 6
sumDigits' :: Int -> Int
sumDigits' i = (sum . map digitToInt . show) i

main :: IO ()
main = interact $ \inputs ->
  let [n, a, b] = map read . words $ inputs :: [Int]
   in show (solve n a b) ++ "\n"