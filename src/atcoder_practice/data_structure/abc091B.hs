-- https://atcoder.jp/contests/abc091/tasks/abc091_b
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

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

solve :: [String] -> [String] -> Int
-- solve ss ts = if maxPoint < 0 then 0 else maxPoint
solve ss ts = max maxPoint 0 -- maxPointが負の場合には存在しないカードを言う方がお得
  where
    afterBlueCard = foldl' (\acc s -> Map.insertWith (+) s 1 acc) Map.empty ss
    afterRedCard = foldl' (\acc s -> Map.insertWith (+) s (-1) acc) afterBlueCard ts -- (-) s 1 accにするとキーがない時に-1ではなく1が入ってしまうので注意。
    maxPoint = snd $ maximumBy (comparing snd) $ Map.toList afterRedCard -- 存在するカードを言った場合の最高値

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        n = (read :: String -> Int) $ head ls
        (ss, rest) = splitAt n $ tail ls
        (m : ts) = rest
     in show (solve ss ts) ++ "\n"
