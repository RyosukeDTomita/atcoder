{-# LANGUAGE CPP #-}

import Control.Arrow ((>>>))
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

frequency :: (Ord a) => [a] -> Map.Map a Int
frequency a = foldl' (\m c -> Map.insertWith (+) c 1 m) Map.empty a

solve :: String -> String
solve s =
  let s' = init s -- 改行文字削除
      freq = frequency s'
      freqList = Map.toList freq
      maxFreq = maximum (map snd freqList) -- 最も多く出現する文字の数
      maxFreqCs = filter ((== maxFreq) . snd) freqList -- 最も多く出現する文字すべて
   in filter (`notElem` (map fst maxFreqCs)) s'

main :: IO ()
main =
  interact $ solve >>> (++ "\n")