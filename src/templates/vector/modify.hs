import Control.Monad (forM_)
import Control.Monad.ST (runST)
import Data.Vector.Unboxed qualified as VU
import Data.Vector.Unboxed.Mutable qualified as VUM

main :: IO ()
main = do
  let vs = VU.fromList ([1, 2, 3] :: [Int])
  print vs
  let vs' = runST $ do
        v <- VU.thaw vs
        VUM.write v 0 10
        VU.freeze v -- [10, 2, 3]に変更
  print vs'