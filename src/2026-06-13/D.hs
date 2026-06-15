-- {-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

-- {-# OPTIONS_GHC -DATCODER #-}
import Data.ByteString.Char8 qualified as BS
import Data.Vector.Unboxed qualified as VU
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

-- ByteString版 read
readInt :: BS.ByteString -> Int
readInt bs =
  case BS.readInt bs of
    Just (x, _) -> x
    Nothing -> error "input is not integer"

maxX = 1000000 -- 最も遅い犯行時刻

-- 人iは犯行開始時刻 x in [S_i, T_i-D] で犯行可能(T_i-D<S_iなら誰とも組めない)。
-- 各xでの犯行可能人数 k_x を差分配列(imos法)で求め、sum $ k_xC2する(時刻xでの反抗可能人数k_x人から2人を選ぶ組み合わせ)
solve :: Int -> [[Int]] -> Int
solve d sts = VU.sum $ VU.map (\k -> k * (k - 1) `div` 2) ks -- ラムダ式はkC2
  where
    -- 誰も犯行が不可能なケースを捨てながら、時刻sで1人入館した、時刻r+1で1人退館したというデータを作っている。
    toEvents :: [Int] -> [(Int, Int)]
    toEvents [s, t]
      | r >= s = [(s, 1), (r + 1, -1)]
      | otherwise = []
      where
        r = t - d
    events = VU.fromList $ concatMap toEvents sts :: VU.Vector (Int, Int)
    -- 各時刻xごとに館に出入りした情報を記載。
    diff = VU.accumulate (+) (VU.replicate (maxX + 2) 0) events -- 退館イベントをr + 1で記載するので maxX + 2の+2している。 つまり、[0..maxX+1]の要素を作るにはmaxX+2の要素数が必要
    -- 累積和で各xでの犯行可能人数k_xを求める
    ks = VU.scanl1' (+) diff

main :: IO ()
main = BS.interact $ \inputs ->
  let ls = BS.lines inputs
      [_, d] = map readInt . BS.words $ head ls :: [Int] -- [犯人候補の数, 犯行に書かかった時間]
      sts = map (map readInt . BS.words) $ drop 1 ls :: [[Int]]
   in ((BS.pack . show) $ solve d sts) <> BS.pack "\n"
