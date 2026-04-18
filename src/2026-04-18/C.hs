-- WA
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wunused-imports #-}

-- {-# OPTIONS_GHC -DATCODER #-}

import Data.ByteString.Char8 qualified as BS
import Data.List (sortOn)
import Data.Set qualified as Set
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

solve :: Int -> Int -> [(Int, Int)] -> Int
solve _ _ abList = Set.size $ go 1 (Set.singleton 1) abList'
  where
    abList' = sortOn fst abList
    -- この実装の場合、同じaの値かつ、bが異なるものをカウントできない。
    go :: Int -> Set.Set Int -> [(Int, Int)] -> Set.Set Int
    go _ obtained [] = obtained
    go itemNow obtained ((a, b) : rest)
      | a /= itemNow = obtained -- 終了
      | Set.notMember b obtained = go a (Set.insert b obtained) rest
      | otherwise = go itemNow obtained rest

main :: IO ()
main = BS.interact $ \inputs ->
  let ls = BS.lines inputs
      ![n, m] = map readInt . BS.words $ head ls :: [Int] -- [アイテムの種類数, 友人の数]
      !abList = dbgId $ map ((\[a, b] -> (a, b)) . map readInt . BS.words) $ drop 1 ls :: [(Int, Int)]
   in BS.pack $ show (solve n m abList) ++ "\n"
