-- 階乗を計算する
factorial:: Int -> Int
factorial 0 = 1
factorial n = product [1..n]
-- 9^nかどうかを再帰でチェックする
isPowerOf9 :: Int -> Bool
isPowerOf9 x
  | x == 1 = True
  | x `mod` 9 == 0 = isPowerOf9 (x `div` 9)
  | otherwise = False
-- a b c dの階乗の合計を足して9^nであるか確認し、判定結果と計算結果を返す
solution:: Int -> Int -> Int -> Int -> (Bool, Int)
solution a b c d = (isPowerOf9 sumAD, sumAD)
  where sumAD = factorial a + factorial b + factorial c + factorial d

main :: IO()
main = do
  let result = [(a, b, c, d, round (logBase 9 (fromIntegral sumAD))) | a <- [0..6], b <- [0..6], c <- [0..6], d <- [0..6], let (isValid, sumAD) = solution a b c d, isValid]
  putStrLn "(a, b, c, d, n)"
  mapM_ print result
