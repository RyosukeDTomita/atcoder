-- https://atcoder.jp/contests/tessoku-book/tasks/tessoku_book_ay
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.List (foldl')
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
solve qs = reverse $ snd $ foldl' go ([], []) qs
  where
    go :: ([String], [String]) -> [String] -> ([String], [String])
    go (stack, output) ("1" : book) = (head book : stack, output) -- 追加
    go (stack@(s : rest), output) ["2"] = (stack, s : output) -- 読み上げ(先頭を出力するだけでpopしない)
    go (stack, output) ["3"] = (tail stack, output) -- 取り出し

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        -- n = (read :: String -> Int) $ head ls
        qs = map words $ tail ls
     in unlines $ solve qs
