-- https://atcoder.jp/contests/abc095/tasks/arc096_a
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Control.Arrow ((>>>))
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

-- | A: ピザAの値段
-- B: ピザBの値段
-- C: ハーフアンドハーフの値段
-- X: ピザAの必要枚数
-- Y: ピザBの必要枚数
solve :: [Int] -> Int
solve [a, b, c, x, y]
  | (aDiffC > 0) && (bDiffC > 0) = c * 2 * max x y
  | aDiffC > 0 = c * x * 2 + b * max (y - x) 0
  | bDiffC > 0 = c * y * 2 + a * max (x - y) 0
  | otherwise = go 0 (0, 0)
  where
    aDiffC = a - (2 * c) -- 正ならピザAを一枚頼むよりもハーフアンドハーフを買うべき
    bDiffC = b - (2 * c) -- 正ならピザBを一枚頼むよりもハーフアンドハーフを買うべき
    cIsGood = (a + b) - (2 * c) > 0 -- ピザA、ピザBが必要ならハーフアンドハーフを買うべき
    go :: Int -> (Int, Int) -> Int
    go result (i, j)
      | i >= x && j >= y = result
      | cIsGood && (x - i) > 0 && (y - j) > 0 = go (result + (2 * c)) (i + 1, j + 1) -- cを買う経済合理性があり、A、B両方が必要ならCを買う
      | (x - i) > 0 = go (result + a) (i + 1, j)
      | (y - j) > 0 = go (result + b) (i, j + 1)

main :: IO ()
main =
  interact $
    words >>> map (read :: String -> Int) >>> solve >>> show >>> (++ "\n")
