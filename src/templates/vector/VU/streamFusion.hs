import Data.Vector.Unboxed qualified as VU

main :: IO ()
main = do
  let v = VU.generate 10000 id
  -- print $ (VU.maximum v, VU.sum v) -- 同じVectorが2回使われるとStream Fusionという最適化がされない。
  print $ VU.foldl' (\(!mx, !sm) vi -> (max mx vi, sm + vi)) (minBound, 0) v
