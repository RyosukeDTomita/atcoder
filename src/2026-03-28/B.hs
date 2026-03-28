{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Control.Monad.ST (runST)
import Data.List (transpose)
import Data.Vector.Unboxed qualified as VU
import Data.Vector.Unboxed.Mutable qualified as VUM
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

frequency :: [Int] -> Int -> VU.Vector Int
-- NOTE: accumulateは第2引数に初期ベクタ、第3引数の(index番号, value)をとり、f valueを初期ベクタのn番目に適用する関数である。
frequency xs maxX = VU.accumulate (+) (VU.replicate (maxX + 1) 0) (VU.fromList [(x, 1) | x <- xs])

updateDep :: VU.Vector Int -> [Int] -> [Int] -> VU.Vector Int
updateDep freq as bs =
  runST $ do
    mv <- VU.thaw freq
    mapM_
      ( \(a, b) -> do
          VUM.modify mv (subtract 1) a
          VUM.modify mv (+ 1) b
      )
      (zip as bs)
    VU.freeze mv

solve :: [Int] -> [Int] -> Int -> Int -> [Int]
solve as bs n m =
  let !curDepNum = dbgId $ frequency as m
      !updatedDepNum = dbgId $ updateDep curDepNum as bs
   in tail $ VU.toList $ VU.zipWith (-) updatedDepNum curDepNum -- NOTE: 先頭は0番目なので捨てる

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      [n, m] = map read . words $ head ls :: [Int]
      [!as, !bs] = transpose $ map (map read . words) $ drop 1 ls :: [[Int]]
   in unlines . map show $ solve as bs n m
