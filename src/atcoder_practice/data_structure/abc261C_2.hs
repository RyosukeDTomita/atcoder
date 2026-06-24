-- https://atcoder.jp/contests/abc261/tasks/abc261_c
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.List (mapAccumL)
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

solve :: [String] -> [String]
solve ss = snd $ mapAccumL go Map.empty ss
  where
    go :: Map.Map String Int -> String -> (Map.Map String Int, String)
    go m s = (m', output)
      where
        -- 挿入と検索を同時に行う
        (justC, m') = Map.insertLookupWithKey (\_ _ o -> o + 1) s 1 m -- キーが見つからない場合にはデフォルト値として1を入れる、キーがある場合にはlambdaでインクリメント
        output = case justC of
          Just w -> s ++ "(" ++ show w ++ ")"
          Nothing -> s

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        -- n = (read :: String -> Int) $ head ls
        ss = tail ls
     in unlines $ solve ss
