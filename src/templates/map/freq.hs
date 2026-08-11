import Data.List (foldl')
import Data.Map.Strict qualified as Map

main :: IO ()
main = do
  -- 頻度マップはStrictを使ったほうが(1+1+1...)のサンクが潰れる
  let freq = foldl' (\m c -> Map.insertWith (+) c 1 m) Map.empty [1, 2, 1, 3, 1]
  print freq
