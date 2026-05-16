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

dropEnd :: Int -> [a] -> [a]
dropEnd n xs = zipWith const xs (drop n xs)

solve :: String -> Int -> String
solve s n =
  let sN = length s
   in -- in drop n $ take (sN - n) s
      (drop n . dropEnd n) s

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        !s = head ls
        !n = read $ ls !! 1 :: Int
     in solve s n ++ "\n"
