-- https://atcoder.jp/contests/abc147/tasks/abc147_c
-- WAになった。
-- {-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.Bits (popCount, shiftL, testBit)
import Data.List (foldl')
import Data.Set qualified as Set
import Debug.Trace (traceShowId)

-- {-# OPTIONS_GHC -DATCODER #-}
#ifdef ATCODER
debug :: Bool ; debug = False
#else
debug :: Bool ; debug = True
#endif

dbgId :: (Show a) => a -> a
dbgId x
  | debug = traceShowId x
  | otherwise = x

detect :: Int -> Int -> [[(Int, Int)]] -> Bool
detect bit n xyss = honests == (Set.toList $ foldl' go Set.empty $ zip [1 ..] xyss)
  where
    -- bitから今回正直者の番号パターンを展開(1始まり)
    honests =
      [ i
        | i <- [1 .. n],
          testBit bit (i - 1)
      ]
    go :: Set.Set Int -> (Int, [(Int, Int)]) -> Set.Set Int
    go acc (i, xys)
      | i `elem` honests = Set.union acc $ Set.fromList $ [x | (x, y) <- xys, y == 1] -- 誤り 正直者の不親切証言を無視している。
      | otherwise = acc

solve :: Int -> [[(Int, Int)]] -> Int
solve n xyss =
  -- popCountは立っているビットの数を数える
  popCount $ -- 誤り先にpopCountしてmaximumする必要がある。なぜなら、立っているビットが最多=bitがでかいではないため
    maximum
      [ bit
        | bit <- [0 .. (1 `shiftL` n) - 1] :: [Int],
          detect bit n xyss
      ]

parse :: [String] -> [[(Int, Int)]]
parse [] = []
parse (a : rest) =
  let a' = (read :: String -> Int) a
      (block, remaining) = splitAt a' rest
      testimony = map parseLine block
   in testimony : parse remaining
  where
    parseLine :: String -> (Int, Int)
    parseLine line =
      let [x, y] = map (read :: String -> Int) $ words line
       in (x, y)

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        n = read $ head ls :: Int
        xyss = parse $ tail ls
     in show (solve n xyss) ++ "\n"
