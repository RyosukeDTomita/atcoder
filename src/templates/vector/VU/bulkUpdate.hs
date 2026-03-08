import Data.Vector.Unboxed qualified as VU

main :: IO ()
main = do
  let xs = [10, 20, 30] :: [Int]
  let vu = VU.fromList xs
  print vu
  -- [tuple]で更新する方法
  let vu' = vu VU.// [(1, 100), (2, 1000)] -- [10, 100, 1000] O(m + n) = O(3 + 2)
  print vu'

  -- Vectorを使って更新する方法
  let updateInfo = VU.zip (VU.fromList [1, 2]) (VU.fromList [100, 1000])
  let vu'' = VU.update vu updateInfo -- [10, 1000, 1000] O(m+n) = O(3 + 2)
  print vu''
