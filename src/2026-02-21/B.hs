{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}

import Data.List (foldl')
import Data.Text.Internal.Fusion (reverseStream)
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

third :: (a, b, c) -> c
third (_, _, z) = z

findJuice :: [Int] -> [Int] -> Int
findJuice [] _ = 0 -- 希望のジュース無しのため水
findJuice _ [] = 0 -- 売り切れも水
findJuice (x : rest) juiceList = if x `elem` juiceList then x else findJuice rest juiceList

-- m: ジュースの種類
-- xss: ジュースの希望リスト
solve :: Int -> [[Int]] -> [Int]
solve m xss =
  let juiceList = [1 .. m]
      goResult = go (juiceList, xss, [])
   in reverse $ third goResult
  where
    -- juiceList
    -- xss
    -- results -- ListなのでO(1)で連結するため逆順で保存している
    go :: ([Int], [[Int]], [Int]) -> ([Int], [[Int]], [Int])
    go (juiceList, [], results) = (juiceList, [], results)
    go (juiceList, (xs : rest), results) =
      let selectedJuice = findJuice xs juiceList
       in if selectedJuice == 0
            then go (juiceList, rest, (0 : results))
            else go (removeOnce selectedJuice juiceList, rest, (selectedJuice : results))

    removeOnce :: Int -> [Int] -> [Int]
    removeOnce _ [] = []
    removeOnce target (y : ys)
      | target == y = ys
      | otherwise = y : removeOnce target ys

parse :: [String] -> [[Int]]
parse [] = []
parse (l : xs : rest) = (map (read :: String -> Int) . words $ xs) : parse rest

main :: IO ()
main =
  interact $ \inputs ->
    let linesInput = lines inputs
        [n, m] = map read . words $ head linesInput :: [Int]
        !ls = parse $ tail linesInput
     in unlines (map show (solve m ls))
