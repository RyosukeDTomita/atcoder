-- https://atcoder.jp/contests/abc364/tasks/abc364_c
-- 2分探索バージョンの3倍のパワーがある!! 1544 ms -> 546 ms
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.ByteString.Char8 qualified as BS
import Data.List (sortOn)
import Data.Ord (Down (..))

readInt :: BS.ByteString -> Int
readInt bs =
  case BS.readInt bs of
    Just (x, _) -> x
    Nothing -> error "input is not integer"

-- 単調増加させ、オーバーするのは何個目か突き止める。二分探索する必要はなかった。
countUntilOver :: Int -> [Int] -> Int
countUntilOver limit xs = 1 + length (takeWhile (<= limit) prefixSums)
  where
    prefixSums = scanl1 (+) . sortOn Down $ xs

solve :: Int -> Int -> Int -> [Int] -> [Int] -> Int
solve n x y as bs = minimum [n, countUntilOver x as, countUntilOver y bs]

main :: IO ()
main =
  BS.interact $ \inputs ->
    let ls = BS.lines inputs
        [n, x, y] = map readInt . BS.words $ head ls
        as = map readInt . BS.words $ ls !! 1
        bs = map readInt . BS.words $ ls !! 2
     in BS.pack $ show (solve n x y as bs) ++ "\n"
