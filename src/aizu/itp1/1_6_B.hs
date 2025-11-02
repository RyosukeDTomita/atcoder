import Control.Monad (replicateM)
import Data.List (sortOn)

toTuple :: [String] -> (Char, Int)
toTuple [suit, rank] =
  (head suit, read rank :: Int)

-- 特定のスートで無いカードを見つけてその配列を返す。
missingCards :: Char -> [(Char, Int)] -> [(Char, Int)]
missingCards suit cards =
  [(suit, rank) | rank <- [1 .. 13], (suit, rank) `notElem` cards] -- 無いカードだけの新しい配列を内包表記で作成している。

main :: IO ()
main = do
  n <- readLn :: IO Int
  -- allCards <- replicateM n $ words <$> getLine
  allCards <- replicateM n $ toTuple . words <$> getLine

  -- 各スートで無いカードを見つける
  let missing = concatMap (\suit -> missingCards suit allCards) ['S', 'H', 'C', 'D']
  mapM_ (\(suit, rank) -> putStrLn $ [suit] ++ " " ++ show rank) missing
