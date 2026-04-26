import Data.Vector.Unboxed qualified as VU

main :: IO ()
main = do
  let v = VU.fromList [10, 20, 30]
  print v
  print $ VU.imap (*) v -- [0 * 10, 20 * 1, 30 * 2] = [0,20,60]
