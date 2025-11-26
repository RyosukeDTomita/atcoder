import Data.List (sort, sortOn)
import Data.Ord (Down (..))

main :: IO ()
main = do
  -- 昇順ソート
  print $ sort [3, 1, 2, 4, 5]
  -- Downを使った降順ソート
  print $ sortOn Down [3, 1, 2, 4, 5]

  -- tupleのsort
  let trumpCards = [("Heart", 3), ("Heart", 1), ("Heart", 4)]
  print $ sortOn snd trumpCards
