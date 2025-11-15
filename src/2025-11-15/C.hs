-- 飴の総量は出せたが、isAnswerは上手く機能していない。ボツ案
solve :: (Int, Int) -> [Int] -> Int
solve (x, y) as =
  if isAnswer
    then candyWeightSum
    else -1
  where
    lcmXY = lcm x y
    minAs = minimum as
    maxAs = maximum as
    tmp = (lcmXY `div` x) - (lcmXY `div` y) -- TODO: 変数名を考える。一個lmcXYを作るごとに埋められる飴の個数の差
    isAnswer = length (filter (\a -> a `mod` tmp == 0) (map (\a -> (a - minAs)) as)) == length as
    maxAsSmallCandyNum = lcmXY * ((maxAs - minAs) `div` tmp) `div` x -- 最も多くの数飴がもらえる子供がもらう、小さい飴の数
    maxAsBigCandyNum = maxAs - maxAsSmallCandyNum -- 最も多くの数飴がもらえる子供がもらう、大きい飴の数
    candyWeightSum = x * maxAsSmallCandyNum + y * maxAsBigCandyNum -- 答えになる飴の数

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      [n, x, y] = map read . words $ head ls :: [Int]
      as = map read . words $ ls !! 1 :: [Int]
   in show $ solve (x, y) as
