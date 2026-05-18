-- {-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wunused-imports #-}

-- {-# OPTIONS_GHC -DATCODER #-}
import Data.ByteString.Char8 qualified as BS
import Data.List (mapAccumL)
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

readInt :: BS.ByteString -> Int
readInt bs =
  case BS.readInt bs of
    Just (x, _) -> x
    Nothing -> error "input is not integer"

-- NOTE: Setは自動で重複削除するので削除されないようにタグをつけている。
-- Fenwick木を使わずに、通常のSetで対応している。
solve :: Int -> [[Int]] -> [Int]
solve x abList = snd $ mapAccumL step (Set.singleton (x, 0)) (zip [0 ..] abList)
  where
    step :: Set.Set (Int, Int) -> (Int, [Int]) -> (Set.Set (Int, Int), Int)
    step set (i, [a, b]) =
      -- NOTE:  -- aとbつまり1クエリで2つの値を区別するために 2 * i + 2と2 * i + 1している
      let set' = Set.insert (a, 2 * i + 2) $ Set.insert (b, 2 * i + 1) set -- insertは O(log n)
       in (set', fst $ Set.elemAt (i + 1) set') -- elemAtはSet内でi番目の数を返す関数 O(log n)
    step _ _ = error "expected pair"

main :: IO ()
main = BS.interact $ \inputs ->
  let ls = BS.lines inputs
      x = readInt $ head ls
      abList = map (map readInt . BS.words) $ drop 2 ls
   in BS.unlines . map (BS.pack . show) $ solve x abList
