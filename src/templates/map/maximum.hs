import Data.List (maximumBy)
import Data.Map qualified as Map
import Data.Ord (comparing)

main :: IO ()
main = do
  let xMap = Map.fromList [("john", 20), ("sigma", 29), ("taro", 15)]
  print xMap
  print $ maximumBy (comparing snd) $ Map.toList xMap
  print $ fst $ maximumBy (comparing snd) $ Map.toList xMap -- キーだけ
