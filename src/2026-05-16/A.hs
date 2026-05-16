{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wunused-imports #-}

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

solve :: String -> Int -> String
solve s n =
  let sN = length s
   in -- in drop n $ take (sN - n) s
      (drop n . take (sN - n)) s

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        !s = head ls
        !n = read $ ls !! 1 :: Int
     in solve s n ++ "\n"
