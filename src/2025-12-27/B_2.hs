{-# LANGUAGE CPP #-}

-- {-# OPTIONS_GHC -DATCODER #-}

import Data.Char (digitToInt)
import Data.List (tails)
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

-- 0から9の数字aをbに変換するのに必要なコストを求める
-- NOTE: + 10することで9 --> 0の変換コストが1になっている
cost :: Char -> Char -> Int
cost a b =
  let aInt = digitToInt a
      bInt = digitToInt b
   in (bInt - aInt + 10) `mod` 10

solve :: Int -> String -> String -> Int
solve m s t =
  -- NOTE: tailsはtailとは異なる関数であることに注意。
  -- ghci> tails "abc"
  -- ["abc","bc","c",""]
  let substringsS = dbgId $ filter ((== m) . length) $ map (take m) (tails s) -- sをm桁だけ取り出す全パターン
   in minimum
        [ sum (zipWith cost t sub) -- 各桁ごとにcostを計算して合計値を出す
          | sub <- substringsS
        ]

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        [n, m] = map read . words $ head ls :: [Int]
        s = ls !! 1
        t = ls !! 2
     in show (solve m s t)
          ++ "\n"
