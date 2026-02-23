-- 親を探す処理をO(1)にした。Vectorが使えないのでAOJだとCompile Errorになる
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}

import Data.List (intercalate, sortOn)
{- ORMOLU_DISABLE -}
import qualified Data.Vector.Unboxed as VU
{- ORMOLU_ENABLE -}
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

solve :: Int -> [(Int, [Int])] -> [String]
solve n treeInfo =
  let treeInfo' = sortOn fst treeInfo
      -- (子, 親)のペアのリストを作成
      parentPairs = [(child, pid) | (pid, children) <- treeInfo', child <- children]
      -- Vectorを使って親の配列を作成 (初期値 -1)
      parentVec = VU.replicate n (-1) VU.// parentPairs -- [(Int, a)]の形式でaに値を差し替えたVectorを返す。
   in map (answer parentVec) treeInfo'

-- Vectorを使ってO(1)で親を取得
findParent :: VU.Vector Int -> Int -> Int
findParent parentVec c = parentVec VU.! c

-- Vectorを使って深さを計算
getDepth :: VU.Vector Int -> Int -> Int
getDepth parentVec nodeId =
  let parentId = findParent parentVec nodeId
   in if parentId == -1
        then 0
        else 1 + getDepth parentVec parentId

answer :: VU.Vector Int -> (Int, [Int]) -> String
answer parentVec (nodeId, children) =
  let parentId = findParent parentVec nodeId
      depth = getDepth parentVec nodeId
      nodeType
        | parentId == -1 = "root"
        | null children = "leaf"
        | otherwise = "internal node"
      childrenStr = "[" ++ intercalate ", " (map show children) ++ "]"
   in "node " ++ show nodeId ++ ": parent = " ++ show parentId ++ ", depth = " ++ show depth ++ ", " ++ nodeType ++ ", " ++ childrenStr

parse :: [String] -> [(Int, [Int])]
parse s =
  let splits = map (map read . words) $ s :: [[Int]]
   in map (\x -> (head x, drop 2 x)) splits

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        n = (read :: String -> Int) $ head ls
        treeInfo = parse $ tail ls
     in unlines (solve n treeInfo)