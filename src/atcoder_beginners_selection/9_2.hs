-- 全ての処理を一つの内包表記に入れたよいシンプルなバージョン
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
solve [n, y] =
  case [ [a, b, c]
         | a <- rangeA n y,
           let target = y - 1000 * n - 9000 * a,
           target `mod` 4000 == 0,
           let b = target `div` 4000,
           let c = n - a - b,
           b >= 0,
           c >= 0
       ] of
    [a, b, c] : _ -> [a, b, c] -- 冒頭[a,b,c]と残りの配列の場合には冒頭のみ返す。
    [] -> [-1, -1, -1] -- [a,b,c]の候補なしの場合

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