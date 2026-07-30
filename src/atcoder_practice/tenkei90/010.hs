-- https://atcoder.jp/contests/typical90/tasks/typical90_j
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}
import Data.ByteString.Char8 qualified as BS
import Debug.Trace (traceShowId)
import Data.Vector.Unboxed qualified as VU

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

readInt :: BS.ByteString -> Int
readInt bs =
  case BS.readInt bs of
    Just (x, _) -> x
    Nothing -> error "input is not integer"


pairs :: [Int] -> [(Int, Int)]
pairs (a : b : rest) = (a, b) : pairs rest
pairs _ = []

parse :: [BS.ByteString] -> [(Int, Int)]
parse ls = pairs $ concatMap (map readInt . BS.words) ls

-- l番目からr-1番目の和を累積和でもとめる。
rangeSum :: VU.Vector Int -> Int -> Int -> Int
rangeSum s l r = s VU.! r - s VU.! l

solve :: [(Int, Int)] -> [(Int, Int)] -> [[Int]]
solve cps lrs = map go lrs
  where
    -- !class1 = dbgId $ map (\(c,p) -> if c == 1 then p else 0) cps
    -- !class2 = dbgId $ map (\(c,p) -> if c == 2 then p else 0) cps
    -- !prefixSum1 = dbgId $ VU.scanl' (+) 0 $ VU.fromList class1
    -- !prefixSum2 = dbgId $ VU.scanl' (+) 0 $ VU.fromList class2
    class1 = map (\(c,p) -> if c == 1 then p else 0) cps
    class2 = map (\(c,p) -> if c == 2 then p else 0) cps
    prefixSum1 = VU.scanl' (+) 0 $ VU.fromList class1
    prefixSum2 = VU.scanl' (+) 0 $ VU.fromList class2
    go :: (Int, Int) -> [Int]
    go (l, r) = [rangeSum prefixSum1 (l - 1) r, rangeSum prefixSum2 (l - 1) r] -- 0-indexなので-1する。rはr+1-1でrのまま

main :: IO ()
main =
    BS.interact $ \inputs ->
    let ls = BS.lines inputs
        n = readInt $ head ls
        (use, rest) = splitAt n $ tail ls
        cps = parse use
        lrs = parse $ tail rest
     in BS.unlines . map (BS.unwords . map (BS.pack . show)) $ solve cps lrs
