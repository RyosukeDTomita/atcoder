import Control.Monad (forM_)
import Control.Monad.ST (runST)
import Data.ByteString.Char8 qualified as BS
import Data.Vector.Unboxed qualified as VU
import Data.Vector.Unboxed.Mutable qualified as VUM

readInt :: BS.ByteString -> Int
readInt bs = case BS.readInt bs of
  Just (x, _) -> x
  Nothing -> 0

solve :: Int -> [Int] -> [Int] -> [Int]
solve n as queries = runST $ do
  -- 0-indexedで管理
  vecA <- VU.thaw (VU.fromList as) -- thawでMutable Vectorに変換

  -- 累積和: S[i] = A[0] + A[1] + ... + A[i-1]
  let cumsum = VU.scanl' (+) 0 (VU.fromList as)
  vecS <- VU.thaw cumsum

  let process [] = return []
      process (1 : x : qs) = do
        let idx = x - 1 -- 問題のxは1スタートなので変換
        -- A[idx] と A[idx+1] をswap
        v1 <- VUM.read vecA idx
        v2 <- VUM.read vecA (idx + 1)
        VUM.write vecA idx v2
        VUM.write vecA (idx + 1) v1

        -- S[idx+1]のみ更新: S[idx+1] = S[idx] + A[idx]
        sIdx <- VUM.read vecS idx
        VUM.write vecS (idx + 1) (sIdx + v2)
        process qs
      process (2 : l : r : qs) = do
        -- 区間和 [l, r] = S[r] - S[l-1]
        sr <- VUM.read vecS r
        slMinus1 <- VUM.read vecS (l - 1)
        res <- process qs
        return ((sr - slMinus1) : res)
      process _ = return []

  process queries

main :: IO ()
main = BS.interact $ \input ->
  let (n : q : rest) = map readInt (BS.words input)
      as = take n rest
      queries = drop n rest
      results = solve n as queries
   in BS.unlines $ map (BS.pack . show) results