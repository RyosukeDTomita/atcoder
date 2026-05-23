-- {-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wunused-imports #-}

-- {-# OPTIONS_GHC -DATCODER #-}
import Control.Monad (when)
import Control.Monad.ST (runST)
import Data.ByteString.Char8 qualified as BS
import Data.STRef (modifySTRef', newSTRef, readSTRef)
import Data.Vector.Unboxed.Mutable qualified as MVec
import Debug.Trace (traceShowId)

#ifdef ATCODER
debug :: Bool ; debug = False
#else
debug :: Bool ; debug = True
#endif

dbgId :: (Show a) => a -> a
dbgId x
  | debug = traceShowId x
  | otherwise = x

readInt :: BS.ByteString -> Int
readInt bs =
  case BS.readInt bs of
    Just (x, _) -> x
    Nothing -> error "input is not integer"

solve :: Int -> Int -> [[Int]] -> [Int]
solve n q qs = runST $ do
  add <- MVec.replicate (n + 1) (0 :: Int) -- add[x]: マスxに積んだ累計回数
  g <- MVec.replicate (q + 1) (0 :: Int) -- g[k] : add[i] >= k なマス数（suffix count）。addの最大値はqなので添字はqまで
  minRef <- newSTRef (0 :: Int) -- minAdd = 全消去回数 = max{ k | g[k] == n }
  let go [] = pure []
      go (query : rest) = case query of
        [1, x] -> do
          old <- MVec.read add x
          MVec.write add x (old + 1)
          MVec.modify g (+ 1) (old + 1)
          m <- readSTRef minRef
          -- 全マスが minAdd+1 以上になったら全消去 = minAdd++（制約上 m+1 <= q）
          gm1 <- MVec.read g (m + 1)
          when (gm1 == n) $ modifySTRef' minRef (+ 1) -- 全マスが m + 1になっているならmiRefを増やす。
          go rest
        [2, y] -> do
          m <- readSTRef minRef -- 現在の全削除回数
          -- m + y が add の最大値(<=q)を超える範囲は g が必ず0なので読まずに0
          ans <- if m + y <= q then MVec.read g (m + y) else pure 0
          (ans :) <$> go rest
        _ -> error "invalid query"
  go qs

main :: IO ()
main =
  BS.interact $ \inputs ->
    let ls = BS.lines inputs
        [n, q] = map readInt . BS.words $ head ls
        qs = map (map readInt . BS.words) $ drop 1 ls :: [[Int]]
     in BS.unlines $ map (BS.pack . show) (solve n q qs)
