-- {-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wunused-imports #-}

-- {-# OPTIONS_GHC -DATCODER #-}
import Control.Monad (forM, forM_)
import Control.Monad.ST (ST, runST)
import Data.Array.ST (STUArray, newArray, readArray, writeArray)
import Data.Array.Unboxed (UArray, listArray, (!))
import Data.Bits (shiftR, (.&.))
import Data.ByteString.Char8 qualified as BS
import Data.IntMap.Strict qualified as IM
import Data.IntSet qualified as IS
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

-- Fenwick木: 位置 i に v を加算 (1-indexed)
bitUpdate :: STUArray s Int Int -> Int -> Int -> Int -> ST s ()
bitUpdate bit n i v
  | i > n = return ()
  | otherwise = do
      x <- readArray bit i
      writeArray bit i (x + v)
      bitUpdate bit n (i + (i .&. (-i))) v

-- Fenwick木: prefixSum >= k となる最小の位置を返す (k番目に小さい要素の位置)
-- pw0 は n 以下の最大の 2 冪
bitKth :: STUArray s Int Int -> Int -> Int -> Int -> ST s Int
bitKth bit n pw0 k0 = go pw0 0 k0
  where
    go 0 pos _ = return (pos + 1)
    go pw pos k
      | pos + pw > n = go (pw `shiftR` 1) pos k
      | otherwise = do
          x <- readArray bit (pos + pw)
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
  let allValues = x : concat abList
      -- 座標圧縮: ユニークな値を昇順に
      sorted = IS.toAscList (IS.fromList allValues)
      n = length sorted
      sortedArr = listArray (1, n) sorted :: UArray Int Int
      -- 値 -> 1-indexed 位置
      idxMap = IM.fromList (zip sorted [1 ..])
      getIdx v = idxMap IM.! v
      pw0 = highestPowerOf2 n
  bit <- newArray (1, n) 0 :: ST s (STUArray s Int Int)
  -- 初期値 X を投入
  bitUpdate bit n (getIdx x) 1
  -- 各クエリ: A_i, B_i を投入して中央値 (i+1 番目に小さい値) を求める
  forM (zip [1 ..] abList) $ \(i, ab) -> do
    forM_ ab $ \v -> bitUpdate bit n (getIdx v) 1
    pos <- bitKth bit n pw0 (i + 1)
    return (sortedArr ! pos)

main :: IO ()
main = BS.interact $ \inputs ->
  let ls = BS.lines inputs
      x = readInt $ head ls :: Int
      abList = map (map readInt . BS.words) $ drop 2 ls :: [[Int]]
   in BS.unlines . map (BS.pack . show) $ solve x abList
