-- https://atcoder.jp/contests/abc166/tasks/abc166_c
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.Array

solve :: Int -> [Int] -> [[Int]] -> Int
solve n hs abList = length . filter id . elems $ good
  where
    decks = listArray (1, n) hs -- 灯台の高さ
    -- 各辺で高い方だけが勝つ。全辺で勝った頂点(=Trueのまま)が良い展望台。辺のない頂点もTrueのまま残る
    good = accumArray (&&) True (1, n) $
      concatMap (\[a, b] -> [(a, decks ! a > decks ! b), (b, decks ! b > decks ! a)]) abList

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      [n, m] = map read . words $ head ls :: [Int]
      hs = map read . words $ ls !! 1 :: [Int]
      abList = map (map read . words) $ drop 2 ls :: [[Int]]
   in show (solve n hs abList) ++ "\n"
