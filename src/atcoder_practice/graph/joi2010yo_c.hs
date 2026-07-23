-- https://atcoder.jp/contests/joi2010yo/tasks/joi2010yo_c
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.Array
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

-- 友達の友達と直接の友達の重複を消して、自分を削除したものが答え
solve :: Int -> [[Int]] -> Int
solve n abList = Set.size . Set.delete 1 . Set.fromList $ (myFriends ++ myFriendsFriends)
  where
    arr = accumArray (flip (:)) [] (1, n) $ concatMap (\[a, b] -> [(a, b), (b, a)]) abList
    myFriends = arr ! 1 -- 友達のリスト
    myFriendsFriends = concatMap (arr !) myFriends -- 友達の友達(重複含む)

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      n = read $ head ls :: Int
      m = read $ ls !! 1 :: Int
      abList = map (map read . words) $ drop 2 ls :: [[Int]]
   in show (solve n abList) ++ "\n"
