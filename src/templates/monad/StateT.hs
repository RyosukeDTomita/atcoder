import Control.Monad (forM_, when)
import Control.Monad.State.Strict (modify', runStateT)

main :: IO ()
main = do
  value <-
    runStateT
      ( do
          forM_
            [1 .. 100000000]
            ( \i -> when (even i) $ do
                modify' (+ i)
            )
      )
      (0 :: Int)
  print value
