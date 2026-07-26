{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.List (foldl')
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

solve :: Int -> Int -> String -> Int
solve m d s = m - Set.size (foldl' go Set.empty $ zip [1 ..] s)
  where
    go :: Set.Set Int -> (Int, Char) -> Set.Set Int
    go acc (i, c)
      | c == 'G' =
          -- そのガードマンの守備範囲
          let guarded =
                filter (\x -> x > 0 && x <= m) $
                  [ i + y
                  | y <- [-d .. d] -- 前後の守備範囲。こう書けばだいぶconcatがいらなかった
                  ]
           in foldl' (flip Set.insert) acc guarded
      | otherwise = acc

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        [m, d] = map read . words $ head ls :: [Int] -- mマスの番号、dがガードマンの守備範囲
        s = ls !! 1
     in show (solve m d s) ++ "\n"
