-- 入力例1しか通らなかったので間違えている実装
import Control.Monad (replicateM)
import Data.Maybe (listToMaybe)
import Data.Set qualified as Set

cal :: [Int] -> Int -> Int
cal ps n = sum [product (take n (drop i ps)) | i <- [0 .. ((length ps) - n)]]

main :: IO ()
main = do
  [n, m] <- map read . words <$> getLine :: IO [Int]
  ss <- replicateM n $ words <$> getLine
  -- print ss

  -- (n - m) + 1で縦列どこつかうかを選ぶ。横列も同様。
  -- e.g. n=3、m=2の時は切り出し方は(3 - 2 + 1)^2=4通り
  let tmp = concat $ map (map (Set.toList . Set.fromList)) ss -- 重複をSetに変換して削除下後にListに戻す。その後concatで次元を一つ下げて[[String]]を[[Char]]にしている。 [["..."],["###"],["#.#"]] --> [".","#","#."]
  print tmp
  let pattern = map length tmp
  print pattern
  print $ cal pattern (n - m + 1)
