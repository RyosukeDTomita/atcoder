import Data.Vector.Unboxed qualified as VU

main :: IO ()
main = do
  let xs = [1, 2, 3] :: [Int]
  -- Vector変換
  let vu = VU.fromList xs
  print vu
  -- Listに戻す
  let xs' = VU.toList vu
  print xs'