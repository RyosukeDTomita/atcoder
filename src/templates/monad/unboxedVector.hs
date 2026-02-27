import Control.Monad (forM_, when)
import Data.Vector.Unboxed.Mutable qualified as VUM

main :: IO ()
main = do
  var <- VUM.replicate 1 (0 :: Int)
  forM_ [1 .. 100000000] $ \i -> do
    when (even i) $ do
      VUM.modify var (+ i) 0
  finalValue <- VUM.read var 0
  print finalValue
