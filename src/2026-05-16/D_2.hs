-- FenWick木を使った実装。
-- {-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wunused-imports #-}

-- {-# OPTIONS_GHC -DATCODER #-}
import Control.Monad.ST (ST, runST)
import Data.Bits (shiftR, (.&.))
import Data.ByteString.Char8 qualified as BS
import Data.IntMap.Strict qualified as IM
import Data.IntSet qualified as IS
import Data.Vector.Unboxed qualified as VU
import Data.Vector.Unboxed.Mutable qualified as VUM
import Debug.Trace (traceShowId, traceShowM)

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

-- Fenwick木: 位置 i に 1 を加算 (1-indexed)
bitUpdate :: VUM.MVector s Int -> Int -> Int -> ST s ()
bitUpdate bit n i
  | i > n = return ()
  | otherwise = do
      x <- VUM.read bit i
      VUM.write bit i (x + 1)
      snap <- VU.freeze bit
      traceShowM ("i=", i, "bit=", snap)
      traceShowM ("update", i, i + (i .&. (-i)))
      bitUpdate bit n (i + (i .&. (-i)))

-- Fenwick木: prefixSum >= k となる最小の位置を返す (k番目に小さい要素の位置)
-- pw0 は n 以下の最大の 2 冪
bitKth :: VUM.MVector s Int -> Int -> Int -> Int -> ST s Int
bitKth bit n pw0 k0 = go pw0 0 k0
  where
    go 0 pos _ = return (pos + 1)
    go pw pos k
      | pos + pw > n = go (pw `shiftR` 1) pos k
      | otherwise = do
          x <- VUM.read bit (pos + pw)
          if x < k
            then go (pw `shiftR` 1) (pos + pw) (k - x)
            else go (pw `shiftR` 1) pos k

-- n 以下の最大の 2 冪
highestPowerOf2 :: Int -> Int
highestPowerOf2 n = go 1
  where
    go p
      | p * 2 > n = p
      | otherwise = go (p * 2)

solve :: Int -> [[Int]] -> [Int]
solve x abList = runST $ do
  let allValues = x : concat abList -- 1次元配列に潰している。
  -- ghci> concat [[1,2], [3,4]]
  -- [1,2,3,4]
  -- 重複削除してsort。後でBITの値リストとして使う。
      sorted = dbgId $ IS.toAscList (IS.fromList allValues)
      n = length sorted
      sortedVec = VU.fromList sorted :: VU.Vector Int

      idxMap = IM.fromList (zip sorted [1 ..])
      pw0 = highestPowerOf2 n -- n以下で最大の2の冪
      getIdx :: Int -> Int
      getIdx v = idxMap IM.! v
  -- NOTE: BIT = Fenwick木
  -- BIT は 1-indexed なのでサイズ n+1 で確保 (index 0 は未使用)
  bit <- VUM.replicate (n + 1) 0 -- i番目がsortedのi番目の個数になる頻度マップ
  bitUpdate bit n (getIdx x)
  -- 各クエリ: A_i, B_i を投入して中央値 (i+1 番目に小さい値) を求める
  -- bit[i] の担当範囲 (幅 = i & -i)
  --   bit[1] : freq[1]      (幅1)
  --   bit[2] : freq[1..2]   (幅2)
  --   bit[3] : freq[3]      (幅1)
  --   bit[4] : freq[1..4]   (幅4)
  --   bit[5] : freq[5]      (幅1)
  --   bit[6] : freq[5..6]   (幅2)
  mapM
    ( \(i, [a, b]) -> do
        traceShowM ("i=", i, "a=", a, "b=", b)
        bitUpdate bit n (getIdx a)
        bitUpdate bit n (getIdx b)
        pos <- bitKth bit n pw0 (i + 1)
        -- sortedVec は 0-indexed なので pos-1
        return (sortedVec VU.! (pos - 1))
    )
    (zip [1 ..] abList)

main :: IO ()
main = BS.interact $ \inputs ->
  let ls = BS.lines inputs
      x = readInt $ head ls :: Int
      abList = map (map readInt . BS.words) $ drop 2 ls :: [[Int]]
   in BS.unlines . map (BS.pack . show) $ solve x abList
