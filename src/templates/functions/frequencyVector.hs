import Control.Monad (forM_)
import Control.Monad.ST (runST)
import Data.Vector.Unboxed qualified as VU
import Data.Vector.Unboxed.Mutable qualified as VUM

-- 0以上maxValue以下の各値の出現回数を数える
frequency :: Int -> [Int] -> VU.Vector Int
frequency maxValue xs = runST $ do
  freq <- VUM.replicate (maxValue + 1) 0
  forM_ xs $ \x ->
    VUM.modify freq (+ 1) x
  VU.freeze freq

frequency' :: Int -> [Int] -> VU.Vector Int
-- NOTE: accumulateは第2引数に初期ベクタ、第3引数の(index番号, value)をとり、f valueを初期ベクタのn番目に適用する関数である。
frequency' maxX xs = VU.accumulate (+) (VU.replicate (maxX + 1) 0) (VU.fromList [(x, 1) | x <- xs])

main :: IO ()
main = do
  let xs = [1, 2, 3, 1, 0, 3, 3]
  print $ frequency 3 xs
  print $ frequency' 3 xs
