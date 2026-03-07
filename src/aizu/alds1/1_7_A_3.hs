-- 親を探す処理をO(1)にした。(array版)
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}

import Data.Array (Array, accumArray, (!))
import Data.List (intercalate, sortOn)
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
      -- Arrayを使って親の配列を作成 (初期値 -1)
      -- accumArray (\_ new -> new) 初期値 (インデックスの範囲) ペアのリスト
      parentArr = accumArray (\_ new -> new) (-1) (0, n - 1) parentPairs
   in map (answer parentArr) treeInfo'

-- Arrayを使ってO(1)で親を取得
findParent :: Array Int Int -> Int -> Int
findParent parentArr c = parentArr ! c

-- Arrayを使って深さを計算
getDepth :: Array Int Int -> Int -> Int
getDepth parentArr nodeId =
  let parentId = findParent parentArr nodeId
   in if parentId == -1
        then 0
        else 1 + getDepth parentArr parentId

answer :: Array Int Int -> (Int, [Int]) -> String
answer parentArr (nodeId, children) =
  let parentId = findParent parentArr nodeId
      depth = getDepth parentArr nodeId
      nodeType
        | parentId == -1 = "root"
        | null children = "leaf"
        | otherwise = "internal node"
      childrenStr = "[" ++ intercalate ", " (map show children) ++ "]"
   in "node " ++ show nodeId ++ ": parent = " ++ show parentId ++ ", depth = " ++ show depth ++ ", " ++ nodeType ++ ", " ++ childrenStr

parse :: [String] -> [(Int, [Int])]
parse s =
  let splits = map (map read . words) s :: [[Int]]
   in map (\x -> (head x, drop 2 x)) splits

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        n = (read :: String -> Int) $ head ls
        treeInfo = parse $ tail ls
     in unlines (solve n treeInfo)
