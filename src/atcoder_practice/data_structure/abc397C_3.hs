-- https://atcoder.jp/contests/abc397/tasks/abc397_c
-- ギリギリACできた。(BangPatternsなし)
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.ByteString.Char8 qualified as BS
import Data.List (foldl')
import Data.Set qualified as Set
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

-- iの左側を求めるのは簡単なので、右側もreverseして同じように求める。
solve :: [Int] -> Int
solve as = maximum $ zipWith (+) ((init . fst) (foldl' go ([], Set.empty) as)) ((reverse . init . fst) (foldl' go ([], Set.empty) (reverse as)))
  where
    -- 各aを追加する前のleftの数字の種類数(= aより手前の要素の種類数)を求める
    go :: ([Int], Set.Set Int) -> Int -> ([Int], Set.Set Int)
    go (output, leftSet) a = (output', leftSet')
      where
        leftSet' = Set.insert a leftSet
        output' = Set.size leftSet : output -- 逆順(添字の降順)に積まれるので、zipWithで足す側の片方をreverseして添字を揃える。

-- ByteString版 read
readInt :: BS.ByteString -> Int
readInt bs = case BS.readInt bs of
  Just (x, _) -> x
  Nothing -> error "input is not integer"

main :: IO ()
main = BS.interact $ \inputs ->
  let ls = BS.lines inputs
      n = readInt $ head ls
      as = map readInt . BS.words $ ls !! 1 :: [Int]
   in ((BS.pack . show) (solve as)) <> BS.pack "\n"
