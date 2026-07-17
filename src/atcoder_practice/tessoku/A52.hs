-- https://atcoder.jp/contests/tessoku-book/tasks/tessoku_book_az
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.Foldable (toList)
import Data.List (foldl')
import Data.Sequence qualified as Seq
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

solve :: [[String]] -> [String]
solve qs = toList $ snd $ foldl' go (Seq.empty, Seq.empty) qs
  where
    go :: (Seq.Seq String, Seq.Seq String) -> [String] -> (Seq.Seq String, Seq.Seq String)
    go (que, output) ("1" : name) = (que Seq.|> head name, output)
    go (que@(q Seq.:<| _), output) ["2"] = (que, output Seq.|> q)
    go (_ Seq.:<| rest, output) ["3"] = (rest, output)

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        -- n = (read :: String -> Int) $ head ls
        qs = map words $ tail ls
     in unlines $ solve qs
