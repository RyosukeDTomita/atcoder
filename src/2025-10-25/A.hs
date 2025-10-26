import Control.Monad (replicateM_, when)

main :: IO ()
main = do
  [n, m] <- map read . words <$> getLine :: IO [Int]
  if (n > m)
    then do
      replicateM_ m (putStrLn "OK")
      replicateM_ (n - m) (putStrLn "Too Many Requests")
    else
      replicateM_ n (putStrLn "OK")
