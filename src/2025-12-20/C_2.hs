-- 方針は良さそうだけど、TLEした。
-- 参考: https://atcoder.jp/contests/abc437/submissions/71839583
{-# LANGUAGE CPP #-}

import Control.Arrow ((>>>))
import Data.List (sort, sortOn, transpose)
import Data.Ord (Down (..))
import Debug.Trace (traceShowId)

#ifdef ATCODER
debug :: Bool ; debug = False
#else
debug :: Bool ; debug = True
#endif

-- 値を表示しつつ、その値を使う場合
dbgId :: (Show a) => a -> a
dbgId x
  | debug = traceShowId x
  | otherwise = x

-- 全体の引く力
solve :: [[[Int]]] -> [Int]
solve caseS = map go caseS
  where
    go case' =
      -- 全匹にソリを引かせた時の力をs
      -- そりに乗せたシカをride
      -- 引くシカをpull
      -- i匹のシカを乗せるとする
      -- s - sum pull P_i >= sum ride W_i
      -- s >= sum pull P_i + sum ride W_i
      let s = sum $ map (!! 1) case'
          ds = sort $ map (\c -> c !! 0 + c !! 1) case'
       in length $ takeWhile (<= s) $ scanl1 (+) ds -- scanl1は初期値なし

parse :: [String] -> [[[Int]]]
parse [] = []
parse (nStr : inputs) =
  let n = read nStr :: Int
      (caseT, rest) = splitAt n inputs
   in map (map (read :: String -> Int) . words) caseT : parse rest

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      t = read $ head ls :: Int
      caseS = parse $ drop 1 ls :: [[[Int]]]
   in unlines $ map show (solve caseS)