{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
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

solve :: Int -> [Int] -> Int
solve n as = go 0 as
  where
    go :: Int -> [Int] -> Int
    go !cnt (ai1 : ai2 : []) = cnt
    go !cnt (ai0 : ai1 : ai2 : rest)
      | ai0 < ai1 && ai1 > ai2 && max 1 (n - 2) >= ai0 = go (cnt + 1) (ai1 : ai2 : rest)
      | otherwise = go cnt (ai1 : ai2 : rest)

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        n = (read :: String -> Int) $ head ls
        as = map read . words $ ls !! 1 :: [Int]
     in show (solve n as) ++ "\n"
