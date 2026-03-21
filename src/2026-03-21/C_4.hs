-- ACできた。
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wunused-imports #-}

-- {-# OPTIONS_GHC -DATCODER #-}
import Data.ByteString.Char8 qualified as BS
import Data.List (foldl')
import Data.Set (Set)
import Data.Set qualified as Set
import Data.Vector (Vector)
import Data.Vector qualified as V
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

solve :: Int -> Int -> Vector BS.ByteString -> Int
solve h w grid =
  let whites = Set.fromList $ getWhiteIndex h w grid
      components = allComponents whites
   in length $ filter (\c -> not (touchesBoundary h w c)) components

-- 白マスの座標一覧を作成する
getWhiteIndex :: Int -> Int -> Vector BS.ByteString -> [(Int, Int)]
getWhiteIndex h w grid =
  [ (i, j)
    | i <- [0 .. h - 1],
      j <- [0 .. w - 1],
      BS.index (grid V.! i) j == '.' -- NOTE: C_2.hsからの改善箇所。Vector化したことでgrid V.! iをO(i)からO(1)に
  ]

-- 白マスの塊にエッジが含まれているか
touchesBoundary :: Int -> Int -> [(Int, Int)] -> Bool
touchesBoundary h w component =
  any (\(i, j) -> i == 0 || i == h - 1 || j == 0 || j == w - 1) component

-- 未訪問白マスがなくなるまでDFSを繰り返し、全連結成分を返す（末尾再帰）
-- ws: 白マスのindex
-- acc: 結果
-- NOTE: C_2.hsでは右再帰だった。
allComponents :: Set (Int, Int) -> [[(Int, Int)]]
allComponents whites = go whites []
  where
    go !ws !acc
      -- NOTE: Setが空になるのが終了条件なので、リストの単一要素で結果が決められないため、畳み込みは使えない
      | Set.null ws = acc
      | otherwise =
          let start = Set.findMin ws
              (comp, ws') = dfs ws start
           in go ws' (comp : acc)

-- 明示的スタックを使った反復DFS（スタックオーバーフロー対策）
dfs :: Set (Int, Int) -> (Int, Int) -> ([(Int, Int)], Set (Int, Int))
dfs whites start = go [start] (Set.delete start whites) []
  where
    go [] !ws !acc = (acc, ws)
    go (cur@(i, j) : stack) !ws !acc =
      let neighbors = [(i - 1, j), (i + 1, j), (i, j - 1), (i, j + 1)]
          validNeighbors = filter (`Set.member` ws) neighbors
          !ws' = foldl' (flip Set.delete) ws validNeighbors -- 今回使ったindexを削除している
       in go (validNeighbors ++ stack) ws' (cur : acc) -- 今回見つかった隣接マスを先頭に追加しているのでDFS。末尾に積むならBFS

main :: IO ()
main = BS.interact $ \inputs ->
  let ls = BS.lines inputs
      [h, w] = map readInt . BS.words $ head ls :: [Int]
      grid = V.fromList (drop 1 ls)
   in (BS.pack . show) (solve h w grid) <> BS.pack "\n"
