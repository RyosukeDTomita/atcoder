import Data.List (foldl', maximumBy)
import qualified Data.Map as Map
import Data.Ord (comparing)

countChars :: String -> Map.Map Char Int
countChars s = foldl' (\m c -> Map.insertWith (+) c 1 m) Map.empty s

findSingleChar :: String -> Char
findSingleChar s = fst $ head $ filter (\(c, n) -> n == 1) $ Map.toList $ countChars s

main :: IO ()
main = do
  s <- getLine
  let c = findSingleChar s
  putStrLn [c]
