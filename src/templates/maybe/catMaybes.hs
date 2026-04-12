import Data.Maybe (catMaybes)

main :: IO ()
main = do
  print $ catMaybes [Just 1, Nothing, Just 2]
