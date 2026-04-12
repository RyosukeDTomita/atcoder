-- echo -e "1\n2\n3" | runghc replicateM_.hs
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

  -- replicateMにlistモナドを渡すと組み合わせの列挙をしてくれる
  print $ replicateM 3 [1, -1] -- [[1,1,1],[1,1,-1],[1,-1,1],[1,-1,-1],[-1,1,1],[-1,1,-1],[-1,-1,1],[-1,-1,-1]]
