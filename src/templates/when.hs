import Control.Monad (when)
import System.Exit (exitSuccess)

main :: IO ()
main = do
  let aList = [1, 2, 3]
  when (length aList > 2) $ do
    putStrLn "High"
    exitSuccess -- プログラムを終了
  putStrLn "End" -- これは実行されない
