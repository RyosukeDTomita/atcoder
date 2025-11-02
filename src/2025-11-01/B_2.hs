-- 方針をAIに伝えてコンテスト後に書いてもらったコード
import Control.Monad (replicateM)
import Data.Set qualified as Set

-- gridからm * mのgridをすべて取り出す。
getSquares :: [String] -> Int -> [[String]]
getSquares grid m =
  [ [take m (drop c row) | row <- take m (drop r grid)] -- rowで行を切り出し、その後左側の式で列を取り出している。
    | r <- [0 .. n - m],
      c <- [0 .. n - m] -- この書き方で二重ループになる
  ]
  where
    n = length grid

-- ｒ=c=0の場合のイメージ(わかりやすさのため、#と.ではなく数字をgridに使っている。)
-- ghci> let grid = ["123", "456", "789"]
-- ghci> [ take 2 (drop 0 row) | row <- take 2 (drop 0 grid)]
-- ["12","45"]
-- ghci> take 2 (drop 0 grid)
-- ["123","456"]
-- ghci> [ take 2 (drop 0 row) | row <- ["123", "456"]]
-- ["12","45"]

-- Set型をかませることで重複を削除している。
countUniqueSquares :: [String] -> Int -> Int
countUniqueSquares grid m =
  Set.size . Set.fromList $ getSquares grid m

main :: IO ()
main = do
  [n, m] <- map read . words <$> getLine
  grid <- replicateM n getLine
  -- print grid
  -- print $ getSquares grid m
  print $ countUniqueSquares grid m
