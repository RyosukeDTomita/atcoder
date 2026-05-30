-- {-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
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

-- 合格者 (L <= P <= R) のうち最大得点の生徒。同点なら最小の出席番号。
-- いなければ -1。
-- 「まだ合格者なし」を Maybe で表すことで初期値のトリックを排除し、
-- foldl' の 1 パスで「最大得点・最小番号」を保持する。
-- Maybeを使うことでデータの変換になってうれしい。
solve :: Int -> Int -> [Int] -> Int
solve l r ps =
  case foldl' go Nothing (zip [1 ..] ps :: [(Int, Int)]) of
    Nothing -> -1
    Just (i, _) -> i
  where
    go :: Maybe (Int, Int) -> (Int, Int) -> Maybe (Int, Int)
    go acc (i', p')
      | p' < l || r < p' = acc -- 範囲外は無視
      | otherwise = case acc of
          Nothing -> Just (i', p')
          Just (_, p)
            | p' > p -> Just (i', p') -- 真に大きいときだけ更新 → 同点は最小番号が残る
            | otherwise -> acc

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        [n, l, r] = map read . words $ head ls :: [Int]
        ps = map read . words $ ls !! 1 :: [Int]
     in show (solve l r ps) ++ "\n"
