{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}
import Debug.Trace (traceShowId)
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

parseLine :: String -> ([Int], String)
parseLine line = (map read nums, str)
  where
    ws = words line
    (nums, [str]) = splitAt (length ws - 1) ws

solve :: [([Int], String)] -> Int
solve absList = y - x
  where
    !y = dbgId $ foldl' (\acc ([a, b], _) -> b - a + acc) 0 absList
    !x = dbgId $ foldl' (\acc ([a, b], s) -> if s == "take" then b - a + acc else acc) 0 absList

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
      -- n = (read :: String -> Int) $ head ls
        absList = map parseLine $ tail ls
      in show (solve absList) ++ "\n"
