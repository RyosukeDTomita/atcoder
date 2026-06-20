-- https://atcoder.jp/contests/abc029/tasks/abc029_c
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
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

solve :: Int -> [String]
solve n = iterate addChar ["a", "b", "c"] !! (n - 1)
  where
    -- chars = "abc"
    addChar :: [String] -> [String]
    addChar ws =
      let !addA = map ('a' :) ws
          !addB = map ('b' :) ws
          !addC = map ('c' :) ws
       in addA ++ addB ++ addC

main :: IO ()
main =
  interact $
    (read :: String -> Int) >>> solve >>> unlines
