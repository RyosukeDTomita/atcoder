-- TLEになった。
-- {-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wunused-imports #-}

-- {-# OPTIONS_GHC -DATCODER #-}
import Data.ByteString.Char8 qualified as BS
import Data.List (foldl')
import Data.Set (Set) -- Set.Setと型で書きたくないのでimport
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

solve :: Int -> Int -> [BS.ByteString] -> Int
solve h w grid =
  let whites = Set.fromList $ getWhiteIndex h w grid
      components = allComponents whites
   in length $ filter (\c -> not (touchesBoundary h w c)) components

-- 白マスの座標一覧を作成する
getWhiteIndex :: Int -> Int -> [BS.ByteString] -> [(Int, Int)]
getWhiteIndex h w grid =
  [ (i, j)
    | i <- [0 .. h - 1],
      j <- [0 .. w - 1],
      BS.index (grid !! i) j == '.' -- [BS.ByteString]だとgrid !! iがO(i)で遅い
  ]

-- 白マスの塊にエッジが含まれているか
touchesBoundary :: Int -> Int -> [(Int, Int)] -> Bool
touchesBoundary h w component =
  any (\(i, j) -> i == 0 || i == h - 1 || j == 0 || j == w - 1) component

-- 未訪問白マスがなくなるまでDFSを繰り返し、全連結成分を返す
allComponents :: Set (Int, Int) -> [[(Int, Int)]]
allComponents whites
  | Set.null whites = []
  | otherwise =
      let start = dbgId $ Set.findMin whites -- iが小さいものが最小
          (comp, remaining) = dfs whites start []
       in comp : allComponents remaining

-- 深さ優先探索で連結成分を探す。
-- whites: 白マスのindex
-- (i, j)
-- acc: 結果格納用
dfs :: Set (Int, Int) -> (Int, Int) -> [(Int, Int)] -> ([(Int, Int)], Set (Int, Int))
dfs whites (i, j) acc =
  let whites' = Set.delete (i, j) whites
      neighbors = [(i - 1, j), (i + 1, j), (i, j - 1), (i, j + 1)] -- i,jに隣接するindex
      validNeighbors = filter (`Set.member` whites') neighbors
   in -- validNeighborsが見つかる限り再帰
      foldl'
        (\(accComp, ws) nb -> dfs ws nb accComp)
        ((i, j) : acc, whites')
        validNeighbors -- nbの配列

main :: IO ()
main = BS.interact $ \inputs ->
  let ls = BS.lines inputs
      [h, w] = map readInt . BS.words $ head ls :: [Int]
      grid = drop 1 ls
   in (BS.pack . show) (solve h w grid) <> BS.pack "\n"
