-- {-# LANGUAGE BangPatterns #-}
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

solve :: [Int] -> [String]
solve [h, w] =
  let topOrBottom = replicate w '#'
      middle = '#' : replicate (w - 2) '.' ++ "#"
   in [topOrBottom] ++ replicate (h - 2) middle ++ [topOrBottom]
solve _ = []

main :: IO ()
main =
  interact $
    words >>> map (read :: String -> Int) >>> solve >>> unlines
