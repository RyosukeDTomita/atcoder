import Control.Monad (replicateM_)

main :: IO ()
main = do
  replicateM_ 1000 (putStrLn "Hello World")