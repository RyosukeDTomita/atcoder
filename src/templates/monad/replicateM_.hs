import Control.Monad (replicateM, replicateM_)

createNZero :: Int -> [Int]
createNZero n = replicate n 0

main :: IO ()
main = do
  let n = 3
  -- replicateMは戻り値が必要
  xs <- replicateM n (readLn :: IO Int)
  print xs
  -- replicateM_は戻り値を捨てる
  replicateM_ n $ print "Hello"
