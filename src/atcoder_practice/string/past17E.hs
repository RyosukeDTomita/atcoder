-- https://atcoder.jp/contests/past17-open/tasks/past17_e
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Control.Arrow ((>>>))
import Data.List (group)
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

-- solve s = map (\x -> [head x] ++ " " ++ show (length x)) $ group $ init s のようにすると区切りがおかしくなるのでおとなしく、unwordsしたほうがよい。A 1B 1C 1D 1E 1
solve :: String -> [String]
solve s = concatMap (\x -> [[head x], (show . length) x]) $ group $ init s

main :: IO ()
main =
  interact $
    solve >>> unwords >>> (++ "\n")
