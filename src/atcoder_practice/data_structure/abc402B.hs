-- https://atcoder.jp/contests/abc402/tasks/abc402_b
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}
import Debug.Trace (traceShowId)
import Data.Sequence qualified as Seq
import Data.List (foldl')

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
solve qs = reverse $ snd $ foldl' go (Seq.empty, []) qs
  where
    go :: (Seq.Seq String, [String]) -> [String] -> (Seq.Seq String, [String])
    go (seq, output) ["1", xStr] = (seq Seq.|> xStr, output)
    go (seq, output) ["2"] = case Seq.viewl seq of
      Seq.EmptyL -> error "input is not valid"
      xStr Seq.:< rest -> (rest, xStr: output)

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        -- q = (read :: String -> Int) $ head ls
        qs = map words $ tail ls
     in unlines $ solve qs
