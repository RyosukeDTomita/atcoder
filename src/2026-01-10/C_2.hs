{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}

import Control.Monad
import Control.Monad.ST
import Data.ByteString (ByteString)
import Data.ByteString.Char8 qualified as BS
import Data.Int (Int64)
import Data.Vector.Unboxed qualified as VU
import Data.Vector.Unboxed.Mutable qualified as VUM
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

readInt :: ByteString -> Int
readInt bs =
  case BS.readInt bs of
    Just (x, _) -> x
    Nothing -> error "input is not integer"

readInt64 :: ByteString -> Int64
readInt64 bs =
  case BS.readInt bs of
    Just (x, _) -> fromIntegral x
    Nothing -> error "input is not integer"

-- 入力をパース
-- 各ケース: ([n,w], cs)
parse :: [ByteString] -> [([Int], [Int64])]
parse [] = []
parse (nw : cs : rest) =
  let [n, w] = map readInt (BS.words nw)
      costs = map readInt64 (BS.words cs)
   in ([n, w], costs) : parse rest
parse _ = error "invalid input"

-- 1ケースを解く
solveCase :: Int -> Int -> [Int64] -> Int64
solveCase n w cs = runST $ do
  -- NOTE: STモナド
  let size = 2 * w

  -- a[p] = Σ C_i where i mod (2W) = p -- xが変わった時に `mod` 2wで一緒に白黒が変わるもの=iを2Wで割った余りが同じマスの合計を求めることで考慮すべきパターンの重複を削る
  a <- VUM.replicate size 0
  forM_ (zip [1 .. n] cs) $ \(i, c) -> do
    let p = i `mod` size
    VUM.modify a (+ c) p

  a' <- dbgId $ VU.freeze a

  -- 円環を直線にすることで連続区間を扱いやすくする
  let b = a' VU.++ a'

  -- 累積和
  let pref = VU.scanl' (+) 0 b

  -- 連続 W マスの最小コスト NOTE: 黒くなる区間は `mod` 2W < Wの条件を満たす必要があるので連続する。
  let windowSum i = pref VU.! (i + w) - pref VU.! i -- i番目からi+w番目までの和
  pure $ minimum [windowSum i | i <- [0 .. size - 1]]

-- 全ケースを解く
solve :: [([Int], [Int64])] -> [Int64]
solve = map (\([n, w], cs) -> solveCase n w cs)

main :: IO ()
main =
  BS.interact $ \input ->
    let ls = BS.lines input
        t = readInt (head ls)
        cases = take t $ parse (tail ls)
        results = solve cases
     in BS.unlines $ map (BS.pack . show) results
