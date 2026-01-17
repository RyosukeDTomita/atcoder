{-# LANGUAGE CPP #-}

import Data.Set qualified as Set
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

solve :: String -> String -> [String] -> [String]
solve s t ws = map (\w -> detectLang s t w) ws

-- wが高橋語の単語か青木語の単語であるか確定させる
detectLang :: String -> String -> String -> String
detectLang s t w
  | w `isSubSet` s && not (w `isSubSet` t) = "Takahashi"
  | w `isSubSet` t && not (w `isSubSet` s) = "Aoki"
  | otherwise = "Unknown" -- どちらか確定できない場合

-- リストAがリストBの部分集合であるかチェックする
isSubSet :: (Ord a) => [a] -> [a] -> Bool
isSubSet listA listB = Set.fromList listA `Set.isSubsetOf` Set.fromList listB

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      -- [n, m] = map read . words $ head ls :: [Int]
      s = ls !! 1 -- 高橋語に使われる文字
      t = ls !! 2 --- 青木後に使われる文字
      -- q = read ls !! 3 -- 単語の数
      ws = map (filter (/= '\n')) (drop 4 ls)
   in unlines $ solve s t ws