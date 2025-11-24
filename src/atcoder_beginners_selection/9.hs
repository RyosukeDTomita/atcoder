import Control.Arrow ((>>>))

-- 10000円札の枚数をx、5000円札の枚数をy、1000円札の枚数をzにする
-- 10000a + 5000b + 1000c = Y
-- a + b + c = N
-- よってc = N - a - bとなるのでこれを代入して
-- 10000a + 5000b + 1000 (N - a - b) = Y
-- 9000a + 4000b = Y - 1000N
-- b = (Y - 1000N - 9000a)/4000
-- よって以下の方針で解を得る。
-- 1. 10000a >= Yかつa >= Nの範囲で(Y - 1000N - 9000a) mod 4000 = 0になるかを調査する。
-- 2. bの値を求め、これが0<=b<=(N - a)の間になるかチェックする
-- 3. c = N - a - bに当てはめて計算し、解があるかチェックする。
solve :: [Int] -> [Int]
solve [n, y]
  | (y `div` 10000) > n = [-1, -1, -1]
  | otherwise =
      let abTuples =
            [ (a, (y - 1000 * n - 9000 * a) `div` 4000)
              | a <- rangeA n y,
                (y - 1000 * n - 9000 * a) `mod` 4000 == 0
            ]
          abTuples' = filter (\(a, b) -> b >= 0 && b <= n - a) abTuples -- bの範囲外のものを落とす
          cs = map (\(a, b) -> n - a - b) abTuples'
       in head
            ( [ [a, b, c]
                | a <- map fst abTuples',
                  b <- map snd abTuples',
                  c <- cs,
                  a + b + c == n && 10000 * a + 5000 * b + 1000 * c == y
              ]
                ++ [[-1, -1, -1]] -- 満たすa,b,cが無い時にはheadが失敗しないように末尾にエラーの場合の値を追加
            )

-- aの取りうる最大値と最小値を求める
rangeA :: Int -> Int -> [Int]
rangeA n y =
  let maxA = y `div` 10000
      minA = max 0 (y - 5000 * n) `div` 5000 -- a>=0のため負の値が入らないようにする
   in [minA .. maxA]

main :: IO ()
main =
  interact $
    words >>> map (read :: String -> Int) >>> solve >>> map show >>> unwords >>> (++ "\n")