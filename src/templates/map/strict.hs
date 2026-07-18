import Data.Map.Strict qualified as Map

main :: IO ()
main = do
  -- 頻度マップなStrict版を使うと1 + 1 + 1...のようなサンクがたまらない
  let xs = "abracadabra"
  let freq = Map.fromListWith (+) [(c, 1 :: Int) | c <- xs]
  print $ Map.toList freq -- [('a',5),('b',2),('c',1),('d',1),('r',2)]
