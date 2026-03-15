import Data.Map qualified as Map

main :: IO ()
main = do
  let m = Map.empty
  let m' = Map.insertWith (+) 'a' 1 m
  print m'
