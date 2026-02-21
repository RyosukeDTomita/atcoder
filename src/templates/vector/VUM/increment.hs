import Control.Monad (forM_)
import Control.Monad.ST (runST)
import Data.Vector.Unboxed qualified as VU
import Data.Vector.Unboxed.Mutable qualified as VUM

-- xsの要素を数えるために見つけるたびにインクリメントを行う。
count :: Int -> [Int] -> VU.Vector Int
count n xs = runST $ do
  xMap <- VUM.replicate n 0
  forM_ xs $ \x -> do
    VUM.modify xMap (+ 1) (x - 1)
  VU.freeze xMap

main :: IO ()
main = do
  let xs = [1, 1, 2, 3, 5, 8, 13]
  print $ count 13 xs
