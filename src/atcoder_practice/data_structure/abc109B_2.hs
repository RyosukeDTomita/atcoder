-- https://atcoder.jp/contests/abc109/tasks/abc109_b
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.Set qualified as S
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

solve :: Int -> [String] -> String
solve n ws
  | S.size (S.fromList ws) /= n = "No" -- 重複した言葉はつかえない
  | otherwise = judge . foldr (\x acc -> go acc x && acc) True $ zip ws $ tail ws -- foldrなら途中で落とせる
  where
    judge :: Bool -> String
    judge result = if result then "Yes" else "No"
    go :: Bool -> (String, String) -> Bool
    go acc (prev, now)
      | last prev == head now = True
      | otherwise = False

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        n = (read :: String -> Int) $ head ls
        ws = tail ls :: [String]
     in (solve n ws) ++ "\n"
