-- 1件WAになった
-- {-# LANGUAGE BangPatterns #-}
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

solve :: [Int] -> String
solve [x, y] = if 9 * x `div` y == 16 then "Yes" else "No"

main :: IO ()
main =
  interact $
    words >>> map (read :: String -> Int) >>> solve >>> (++ "\n")
