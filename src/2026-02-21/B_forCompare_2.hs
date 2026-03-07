{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}

import Data.List (foldl', mapAccumL, uncons)
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

-- m: ジュースの種類
-- xss: ジュースの希望リスト
solve :: Int -> [[Int]] -> [Int]
solve m xss =
  let alreadyPicked = []
   in reverse $ snd $ go alreadyPicked xss []
  where
    -- NOTE: B_forCompare.hsを受けて引数を分割してgoを書いた。
    go :: [Int] -> [[Int]] -> [Int] -> ([Int], [Int])
    go ap [] results = (ap, results)
    go ap (xs : rest) results = case uncons xs' of
      Nothing -> go ap rest (0 : results)
      Just (x, _) -> go (x : ap) rest (x : results)
      where
        xs' = dropWhile (`elem` ap) xs -- すでに選ばれたジュースを希望リストから削除する。

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
