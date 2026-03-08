{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}

-- {-# OPTIONS_GHC -DATCODER #-}
import Data.ByteString (ByteString)
import Data.ByteString.Char8 qualified as BS
import Data.IntMap.Strict qualified as IM
import Data.List (sort)
import Data.Maybe (fromJust)
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

readInt :: BS.ByteString -> Int
readInt bs =
  case BS.readInt bs of
    Just (x, _) -> x
    Nothing -> error "input is not integer"

-- kをmultiSetから1つ削除(使用)
dec :: Int -> IM.IntMap Int -> IM.IntMap Int
dec k mp =
  case IM.lookup k mp of
    Just 1 -> IM.delete k mp
    Just c -> IM.insert k (c - 1) mp
    _ -> mp

-- Lが成立するかチェックする
-- L = a_i + a_jを満たすような組み合わせがあるか
ok :: [Int] -> Int -> Bool
ok as l = go as freqA
  where
    freqA =
      IM.fromListWith
        (+)
        [ (a, 1)
          | a <- as
        ]
    go [] _ = True
    go (x : xs) freq =
      case IM.lookup x freq of
        Nothing -> go xs freq
        Just _ ->
          let freq' = dec x freq -- 1つ使用
           in if x == l
                then go xs freq'
                else
                  let y = l - x -- 相方
                   in case IM.lookup y freq' of
                        Nothing -> False
                        Just _ -> go xs (dec y freq')

-- Lはaの最大値 or 2つの要素の和で表される
-- つまり、L = max as + a
-- 逆にL - aを満たす相方が存在するかで判定できる。
-- 以降は全探索の範囲を狭める
-- 元の本数をkとすると sum as = k * Lが成り立つ。
-- k <= N <= 2kとなる範囲でL = sum as `div` kを列挙する
-- これを解くと k >= (N `div` 2)、k <= N
solve :: Int -> [Int] -> [Int]
solve n as =
  let !sumA = sum as
      ls =
        [ (sumA `div` k)
          | k <- [(n + 1) `div` 2 .. n], -- (n+1)することで切り上げを行っている。
            sumA `mod` k == 0
        ]
   in sort $ filter (ok as) ls

main :: IO ()
main =
  BS.interact $ \inputs ->
    let ls = BS.lines inputs
        n = readInt $ head ls
        as = map readInt . BS.words $ ls !! 1 :: [Int]
     in BS.unwords (map (BS.pack . show) (solve n as)) <> BS.pack "\n"
