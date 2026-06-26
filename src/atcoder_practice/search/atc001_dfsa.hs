-- https://atcoder.jp/contests/atc001/tasks/dfs_a
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

-- {-# OPTIONS_GHC -DATCODER #-}
import Data.Array (Array, bounds, inRange, listArray, (!))
import Data.ByteString.Char8 qualified as BS
import Data.Set qualified as Set
import Debug.Trace (traceShowId)

#ifdef ATCODER
debug :: Bool ; debug = False
#else
debug :: Bool ; debug = True
#endif

dbgId :: (Show a) => a -> a
dbgId x
  | debug = traceShowId x
  | otherwise = x

-- ByteString版 read
readInt :: BS.ByteString -> Int
readInt bs =
  case BS.readInt bs of
    Just (x, _) -> x
    Nothing -> error "input is not integer"

-- 家(s)から塀(#)を避けて魚屋(g)へ到達できるか判定する
-- 座標を変えつつ、各マスにアクセスするため、O(1)で要素にアクセスできるArrayを採用
solve :: Int -> Int -> [BS.ByteString] -> Bool
solve h w css = dfs Set.empty [start]
  where
    -- startとgoalの座標
    start = findCell 's'
    goal = findCell 'g'

    -- \| 特定の文字のマスを探す
    findCell :: Char -> (Int, Int)
    findCell c =
      head
        [ (i, j)
          | i <- [0 .. h - 1],
            j <- [0 .. w - 1],
            grid ! (i, j) == c
        ]

    dfs :: Set.Set (Int, Int) -> [(Int, Int)] -> Bool
    dfs _ [] = False
    dfs visited (p : ps)
      | p == goal = True
      | p `Set.member` visited = dfs visited ps -- すでにチェックした座標はスルー
      | otherwise = dfs (Set.insert p visited) (nexts p ++ ps)

    -- \| 上下左右で、街の内側かつ塀でない区画
    nexts :: (Int, Int) -> [(Int, Int)]
    nexts (i, j) =
      [ (ni, nj)
        | (di, dj) <- [(-1, 0), (1, 0), (0, -1), (0, 1)],
          let ni = i + di,
          let nj = j + dj,
          inRange (bounds grid) (ni, nj), -- Array (Int, Int) Charになっていることに注意
          grid ! (ni, nj) /= '#' -- 柵
      ]

    -- grid !(i,j): 座標(j,i)の区画。
    -- NOTE: タプルを添字にしたArrayを作っている。こんなことができるのかすごい
    grid :: Array (Int, Int) Char
    grid = listArray ((0, 0), (h - 1, w - 1)) $ concatMap BS.unpack css

main :: IO ()
main = BS.interact $ \inputs ->
  let ls = BS.lines inputs
      [h, w] = map readInt . BS.words $ head ls :: [Int]
      css = take h $ tail ls
   in if solve h w css then "Yes\n" else "No\n"
