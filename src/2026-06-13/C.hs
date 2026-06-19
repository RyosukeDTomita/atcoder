{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

-- {-# OPTIONS_GHC -DATCODER #-}
import Data.ByteString.Char8 qualified as BS
import Data.List (foldl', sortOn)
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

readPair :: BS.ByteString -> (Int, Int)
readPair l =
  case map readInt (BS.words l) of
    [c, v] -> (c, v)
    _ -> error "expected two integers"

-- 点iが答えに含まれるためにはxj<xiかつyj<yiを満たす点jが存在しない必要がある。愚直に調査するとTLE
-- 辺上を含まないので等号はセーフ。
-- そのままカウントすると間に合わないのでxでソートする。
-- すると、iに対してiより先に出てきた値は全てxが小さい or 同じが保証されているので、これまでに登場したy座標の最小値がyiよりも小さければ内部に点が打たれるので不適になる
solve :: [(Int, Int)] -> Int
solve xys = fst $ foldl' go (0, 300001) (sortOn fst xys) -- y <= Nのため300001を初期値とする。
  where
    go :: (Int, Int) -> (Int, Int) -> (Int, Int)
    go (cnt, minY) (_, y)
      | y < minY = (cnt + 1, y) -- yの最小値を更新する
      | otherwise = (cnt, minY)

main :: IO ()
main = BS.interact $ \inputs ->
  let ls = BS.lines inputs
      -- n = readInt $ head ls :: Int
      !xys = map readPair $ drop 1 ls :: [(Int, Int)]
   in ((BS.pack . show) $ solve xys) <> BS.pack "\n"
