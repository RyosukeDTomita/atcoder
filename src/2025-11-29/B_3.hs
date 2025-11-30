-- https://atcoder.jp/contests/abc434/submissions/71303570 の解答を参考に作成
import Control.Monad (replicateM, replicateM_, when)
import Data.Array (Array, accumArray, elems)
import Data.List (transpose)
import Text.Printf (printf)

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      [n, m] = map read . words $ head ls :: [Int]
      [as, bs] = transpose . map (map read . words) $ tail ls :: [[Int]]
      ary = accumArray (flip (:)) [] (1, m) $ zip as bs -- zip as bsでindexと値のペアを作り、インデックスごとの数字を集める
      -- e.g. [(4,92),(1,16),(3,77),(4,99),(2,89),(3,8),(1,40),(5,56),(1,40),(4,77)]
      -- flip (:) [] (4,92) はこのように展開される (4, 92) : []
      -- [(4,92)]
      -- array (1,5) [(1,[40,40,16]),(2,[89]),(3,[8,77]),(4,[77,99,92]),(5,[56])]
      result = map (\xs -> fromIntegral (sum xs) / fromIntegral (length xs)) $ elems ary :: [Double]
   in -- elemsで配列に戻す
      -- [[40,40,16],[89],[8,77],[77,99,92],[56]]
      unlines $ map (printf "%.20f") result
