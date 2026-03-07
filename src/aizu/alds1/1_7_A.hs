-- TLEになった。
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}

import Data.List (find, intercalate, sortOn)
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

solve :: [(Int, [Int])] -> [String]
solve treeInfo =
  let treeInfo' = sortOn fst treeInfo
   in map (answer treeInfo') treeInfo'

-- まとめて計算してキャッシュする必要がありそう。
-- 1要素ずつではなく、まとめて親を求められないか
findParent :: [(Int, [Int])] -> Int -> Int
findParent treeInfo c = case find (\(_, children) -> c `elem` children) treeInfo of
  Just (p, _) -> p
  Nothing -> -1

-- -1(根)がみつかるまでfindParentしているのでめちゃくちゃ重い
getDepth :: [(Int, [Int])] -> Int -> Int
getDepth treeInfo nodeId =
  let parentId = findParent treeInfo nodeId
   in if parentId == -1
        then 0
        else 1 + getDepth treeInfo parentId

answer :: [(Int, [Int])] -> (Int, [Int]) -> String
answer treeInfo (nodeId, children) =
  let parentId = findParent treeInfo nodeId
      depth = getDepth treeInfo nodeId
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
        _ = (read :: String -> Int) $ head ls
        treeInfo = parse $ tail ls
     in unlines (solve treeInfo)
