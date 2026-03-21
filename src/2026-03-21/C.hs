-- まずかまずそうだったので途中で書くのをやめた。
{- ormolu:disable -}
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wunused-imports #-}

-- {-# OPTIONS_GHC -DATCODER #-}
import Data.ByteString.Char8 qualified as BS
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

solve :: Int -> Int -> [BS.ByteString] -> Int
solve h w shws =
  let whiteIndex = getWhiteIndex h w shws
      --  in fst $ head $ dbgId $ whiteIndex
      setC = findC whiteIndex
   in length setC

-- 白色のマスのindexを求める
getWhiteIndex :: Int -> Int -> [BS.ByteString] -> [(Int, Int)]
getWhiteIndex h w sss =
  [ (i, j)
    | i <- [0 .. h - 1],
      j <- [0 .. w - 1],
      BS.index (sss !! i) j == '.'
  ]

-- 集合Cを求める
findC :: [(Int, Int)] -> [[(Int, Int)]]
findC whiteIndex = go [] whiteIndex
  where
    go :: [[(Int, Int)]] -> [(Int, Int)] -> [[(Int, Int)]]
    go result (ij : whiteIndex)
      -- マスの辺が白い場合集合Cの対象でない
      | fst ij == 0 = go result whiteIndex
      | snd ij == 0 = go result whiteIndex
      | otherwise = [[(0, 0)]] -- ここで周りが黒か判定するのが困難なことに気がついたので方針を変えた。

main :: IO ()
main = BS.interact $ \inputs ->
  let ls = BS.lines inputs
      [h, w] = map readInt . BS.words $ head ls :: [Int]
      shws = drop 1 ls
   in (BS.pack . show) (solve h w shws) <> BS.pack "\n"
