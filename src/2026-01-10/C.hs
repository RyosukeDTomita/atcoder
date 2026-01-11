-- TLE
{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}

-- {-# OPTIONS_GHC -DATCODER #-}
import Data.ByteString (ByteString)
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

readInt :: BS.ByteString -> Int
readInt bs =
  case BS.readInt bs of
    Just (x, _) -> x
    Nothing -> error "input is not integer"

-- マスを塗るコストはcsに格納されている。
-- 全リストcsに対してリストのindexをi、wは入力より、xを正解数とすると
-- ((i + 1) + x) `mod` (2*w) < wとなるマスに対してマスを黒に塗る時のコストを求め、最小値を求める。
solve :: [([Int], [Int])] -> [Int]
solve [] = []
solve (i : rest) =
  -- let tmp = dbgId parseInput
  --  in snd $ head tmp
  let [n, w] = fst i
      caseT = snd i
   in whichPaint n w caseT : solve rest

-- paintするマスの候補を作り最小値を計算する
whichPaint :: Int -> Int -> [Int] -> Int
whichPaint n w caseT =
  let allPattern =
        dbgId $
          [ map (subtract 1) $ filter (\i -> ((i + x) `mod` (2 * w)) < w) [1 .. n]
            | x <- [0 .. 2 * w]
          ]
      allCosts = map (map (\i -> caseT !! i)) allPattern
   in foldl findMin maxBound allCosts

-- 最小の合計値を探す
findMin :: Int -> [Int] -> Int
findMin minCost candidate =
  let minCost' = sum candidate
   in if minCost' < minCost then minCost' else minCost

-- 入力をパースする
parse :: [ByteString] -> [([Int], [Int])]
parse [] = []
parse (nw : i : rest) =
  let [n, w] = map readInt (BS.words nw) :: [Int]
      caseT = map readInt (BS.words i) :: [Int]
   in ([n, w], caseT) : parse rest

main :: IO ()
main =
  BS.interact $ \inputs ->
    let ls = BS.lines inputs
        t = readInt $ head ls
        caseTs = dbgId $ parse $ tail ls
        results = solve caseTs
     in BS.unlines $ map (BS.pack . show) results