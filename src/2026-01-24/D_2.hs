-- TLEした
{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}

-- {-# OPTIONS_GHC -DATCODER #-}
import Control.Monad.ST (ST)
import Data.ByteString (ByteString)
import Data.ByteString.Char8 qualified as BS
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

swap :: (VUM.Unbox a) => VUM.MVector s a -> Int -> Int -> ST s ()
swap v i j = do
  xi <- VUM.read v i
  xj <- VUM.read v j
  VUM.write v i xj
  VUM.write v j xi

solve :: [Int] -> [[Int]] -> [Int]
solve as qs = reverse $ go [] (VU.fromList as) qs
  where
    go results _ [] = results
    go results aVU (q : rest)
      | head q == 1 =
          let x = (q !! 1) - 1
              aVU' = VU.modify (\v -> swap v x (x + 1)) aVU
           in go results aVU' rest
      | head q == 2 =
          let l = (q !! 1) - 1
              r = (q !! 2) - 1
              result = VU.sum (VU.slice l (r - l + 1) aVU)
           in go (result : results) aVU rest
      | otherwise = [-1]

main :: IO ()
main = BS.interact $ \inputs ->
  let ls = BS.lines inputs
      [n, q] = map readInt . BS.words $ head ls :: [Int]
      as = map readInt . BS.words $ ls !! 1 :: [Int]
      qs = map (map readInt . BS.words) $ drop 2 ls :: [[Int]]
   in BS.unlines . map (BS.pack . show) $ solve as qs