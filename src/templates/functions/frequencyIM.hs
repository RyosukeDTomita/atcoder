import Data.IntMap.Strict qualified as IM
import Data.List (foldl', maximumBy)
import Data.Ord (comparing)

frequency :: [Int] -> IM.IntMap Int
frequency xs = foldl' (\m x -> IM.insertWith (+) x 1 m) IM.empty xs

mostFrequent :: IM.IntMap Int -> Maybe (Int, Int)
mostFrequent im
  | IM.null im = Nothing
  | otherwise = Just $ maximumBy (comparing snd) (IM.toList im)

main :: IO ()
main = do
  let im = frequency [1, 2, 3, 1, 2, 2]
  print im
  print $ mostFrequent im
  case mostFrequent im of
    Nothing -> print "Nothing"
    Just (i, cnt) -> do
      print i
      print cnt
