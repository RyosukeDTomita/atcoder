{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}

-- {-# OPTIONS_GHC -DATCODER #-}

import Control.Monad.ST (runST)
import Data.ByteString (ByteString)
import Data.ByteString.Char8 qualified as BS
import Data.List (sortOn, transpose)
import Data.Ord (Down (..))
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

-- ByteString版 read
readInt :: BS.ByteString -> Int
readInt bs =
  case BS.readInt bs of
    Just (x, _) -> x
    Nothing -> error "input is not integer"

solve :: Int -> Int -> Int -> [Int] -> [Int] -> [[Int]]
solve h0 w0 n hs ws = runST $ do
  let hsVec = VU.fromList hs
      wsVec = VU.fromList ws
      psSortedByH = sortOn (Down . (hsVec VU.!)) [0 .. n - 1]
      psSortedByW = sortOn (Down . (wsVec VU.!)) [0 .. n - 1]
      indicesByH = VU.fromList psSortedByH
      indicesByW = VU.fromList psSortedByW

  used <- VUM.replicate n False -- 使ったピースのindexをTrueにする
  matrix <- VUM.replicate n (0, 0)

  -- まだ使われていないピースのindexを見つける
  let findNotUsedP indicesVec !p =
        if p >= n
          then pure p -- runSTモナドなので、値を返すときにはpureでラップする必要がある。
          else do
            u <- VUM.read used (indicesVec VU.! p)
            if u then findNotUsedP indicesVec (p + 1) else pure p
      -- remainingCnt -- 残りの要素数
      -- currentH -- 現在の高さ
      -- currentW -- 現在の幅
      -- pH -- 高さ順のindex
      -- pW -- 幅順のindex
      loop !remainingCnt !currentH !currentW !pH !pW
        | remainingCnt == 0 = pure ()
        | otherwise = do
            pH' <- findNotUsedP indicesByH pH
            pW' <- findNotUsedP indicesByW pW
            let iH = indicesByH VU.! pH' -- 候補h
                iW = indicesByW VU.! pW' -- 候補w
                i = if hsVec VU.! iH == currentH then iH else iW -- 高さ優先
                hi = hsVec VU.! i
                wi = wsVec VU.! i
            VUM.write matrix i (currentH - hi + 1, currentW - wi + 1)
            VUM.write used i True
            if hi == currentH
              then loop (remainingCnt - 1) currentH (currentW - wi) pH' pW'
              else loop (remainingCnt - 1) (currentH - hi) currentW pH' pW'

  loop n h0 w0 0 0
  matrix' <- VU.unsafeFreeze matrix -- 不変Vectorにする
  let ansX = VU.map fst matrix'
      ansY = VU.map snd matrix'
  pure $ transpose [VU.toList ansX, VU.toList ansY]

main :: IO ()
main = BS.interact $ \inputs ->
  let ls = BS.lines inputs
      [h, w, n] = map readInt . BS.words $ head ls :: [Int]
      hws = map (map readInt . BS.words) $ drop 1 ls :: [[Int]]
      [hs, ws] = transpose hws
   in BS.unlines . map (BS.unwords . map (BS.pack . show)) $ solve h w n hs ws
