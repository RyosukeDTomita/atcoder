import Control.Monad (replicateM)

main :: IO ()
main = do
  n <- readLn :: IO Int
  intList <- replicateM n readLn :: IO [Int]
  print intList