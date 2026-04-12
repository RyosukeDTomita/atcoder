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

solve :: String -> String
solve s = go s
  where
    go :: String -> String
    go [] = ""
    go s@(c : rest) = if c == 'o' then go rest else s

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        _ = (read :: String -> Int) $ head ls
        s = ls !! 1
     in solve s ++ "\n"
