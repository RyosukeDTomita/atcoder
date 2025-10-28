import Control.Monad

main :: IO ()
main = do
  n <- readLn
  wordList <- replicateM n getLine
  print wordList
