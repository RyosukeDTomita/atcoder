-- https://atcoder.jp/contests/tessoku-book/tasks/tessoku_book_bb
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.List (foldl')
import Data.Map qualified as Map
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
solve qs = reverse $ snd $ foldl' go (Map.empty, []) qs
  where
    go :: (Map.Map String String, [String]) -> [String] -> (Map.Map String String, [String])
    go (m, output) (iStr : rest)
      | iStr == "1" = let [name, grade] = rest in (Map.insert name grade m, output)
      | iStr == "2" = let name = head rest in (m, m Map.! name : output)

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        q = (read :: String -> Int) $ head ls
        qs = map words $ tail ls
     in unlines $ solve qs
