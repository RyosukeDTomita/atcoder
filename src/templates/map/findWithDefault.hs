import Data.Map qualified as Map

main :: IO ()
main = do
  let m = Map.fromList [('a', 1), ('b', 2)]
  print $ Map.findWithDefault 0 'a' m -- 1
  print $ Map.findWithDefault 0 'b' m -- 2
  print $ Map.findWithDefault 0 'c' m -- 0(デフォルト値)
