-- https://atcoder.jp/contests/abc147/tasks/abc147_c
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.Bits (popCount, shiftL, testBit)
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

-- bitで仮定した正直者の証言がすべて矛盾しないか判定する
detect :: Int -> Int -> [[(Int, Int)]] -> Bool
detect bit n xyss =
  and
    [ testBit bit (x - 1) == (y == 1) -- x-1のbitが立っていない場合: False == (0 == 1)でTrue。bitが立っている場合にはTrue = (1==1)でTrue。正直者の話は必ずTrueになる。
      | i <- [0 .. n - 1],
        testBit bit i, -- 内包表記は先に検証を書くことjもできる。
        (x, y) <- xyss !! i
    ]

solve :: Int -> [[(Int, Int)]] -> Int
solve n xyss =
  maximum
    [ popCount bit -- NOTE: 立っているビット数最大をもとめるためmaximumの前にpopCountしている。
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
