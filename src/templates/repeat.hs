import Control.Monad (replicateM_, when)

main :: IO ()
main = do
  replicateM_ 3 (putStrLn "Hello, World")
