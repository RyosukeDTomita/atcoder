import Control.Monad (forM_, when)
import Data.IORef (modifyIORef', newIORef, readIORef)

main :: IO ()
main = do
  -- 偶数だけを足し算する。varは破壊的変更が可能。
  var <- newIORef (0 :: Int)
  forM_ [1 .. 100000000] $ \i -> do
    when (even i) $ do
      modifyIORef' var (+ i)
  -- value <- readIORef var
  -- print value
  finalValue <- readIORef var
  print finalValue
