{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wunused-imports #-}

-- {-# OPTIONS_GHC -DATCODER #-}

import Data.ByteString.Char8 qualified as BS
import Data.Foldable (foldl')
import Data.IntMap.Strict qualified as IM
import Data.IntSet qualified as IS
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

solve :: [(Int, Int)] -> Int
solve abList = IS.size $ bfs (IS.singleton 1) [1]
  where
    -- aを渡すとbがもらえる、を有向辺a->bと見たグラフ
    graph :: IM.IntMap [Int]
    graph = IM.fromListWith (++) [(a, [b]) | (a, b) <- abList]
    bfs :: IS.IntSet -> [Int] -> IS.IntSet
    bfs visited [] = visited
    bfs visited (x : xs) =
      let neighbors = IM.findWithDefault [] x graph -- xから獲得できるアイテム
      -- visitedとnewNodesを同時に更新することで計算コストを減らす。
          step :: (IS.IntSet, [Int]) -> Int -> (IS.IntSet, [Int])
          step (!v, ns) n
            | n `IS.member` v = (v, ns)
            | otherwise = (n `IS.insert` v, n : ns)
          (visited', newNodes) = foldl' step (visited, []) neighbors
       in bfs visited' (newNodes ++ xs)

main :: IO ()
main = BS.interact $ \inputs ->
  let ls = BS.lines inputs
      !abList = map ((\[a, b] -> (a, b)) . map readInt . BS.words) $ drop 1 ls :: [(Int, Int)]
   in BS.pack $ show (solve abList) ++ "\n"
