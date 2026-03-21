-- {-# LANGUAGE BangPatterns #-}
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

solve :: Int -> [[Int]] -> String
solve n cijs =
  let abc =
        dbgId $
          [ (a, b, c)
            | a <- [0 .. n - 1],
              b <- [a + 1 .. n - 1],
              c <- [b + 1 .. n - 1],
              (cijs !! a !! (b - a - 1) + cijs !! b !! (c - b - 1)) < cijs !! a !! (c - a - 1)
          ]
   in if length abc > 0 then "Yes" else "No"

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      n = read $ head ls :: Int
      cijs = map (map read . words) $ drop 1 ls :: [[Int]]
   in solve n cijs ++ "\n"
