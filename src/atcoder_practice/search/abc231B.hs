-- https://atcoder.jp/contests/abc231/tasks/abc231_b
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.List (foldl', maximumBy)
import Data.Map qualified as Map
import Data.Ord (comparing)
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

solve :: [String] -> String
solve ss = fst $ maximumBy (comparing snd) $ Map.toList freq
  where
    freq = foldl' (\acc s -> Map.insertWith (+) s 1 acc) Map.empty ss

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        n = (read :: String -> Int) $ head ls
        ss = tail ls
     in (solve ss) ++ "\n"
