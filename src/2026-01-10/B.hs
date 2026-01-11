{-# LANGUAGE CPP #-}

import Data.List (elemIndex, sort)
import Data.Maybe (fromJust)
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

solve :: [Int] -> [Int]
solve ts = map (\x -> fromJust (elemIndex x ts) + 1) $ take 3 $ sort ts

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        n = (read :: String -> Int) $ head ls
        ts = map read . words $ ls !! 1 :: [Int]
     in unwords (map show (solve ts)) ++ "\n"