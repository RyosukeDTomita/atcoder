-- https://atcoder.jp/contests/abc434/submissions/71305609 の方針を参考に作成
import Data.Map qualified as Map
import Text.Printf (printf)

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      [_, m] = map read . words $ head ls :: [Int]
      abList = map (map read . words) $ tail ls :: [[Int]]
      aNs = Map.elems $ Map.fromListWith (+) $ map (\[x, y] -> (x, 1)) abList -- 各種類の鳥の出現回数のリスト
      sumBs = Map.elems $ Map.fromListWith (+) $ map (\[x, y] -> (x, y)) abList -- 種類ごとの重量の合計のリスト
      result = zipWith (\x y -> fromIntegral x / fromIntegral y) sumBs aNs :: [Double] -- /はFractional型しか使えないため、Intは適用できない。そのため、fromIntegralでDoubleに変換している。
   in unlines $ map (printf "%.20f") result
