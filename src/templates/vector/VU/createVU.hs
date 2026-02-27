import Data.Vector.Unboxed qualified as VU

main :: IO ()
main = do
  -- fromListを使うと一度Listを作る必要があるため
  let xs = [1, 2, 3] :: [Int]
  -- Vector変換
  let vu = VU.fromList xs
  print vu
  -- Listに戻す
  let xs' = VU.toList vu
  print xs'

  -- enumFromNを使うほうが高速
  let vu' = VU.enumFromN (1 :: Int) 3 -- 1から3までの連番を作る
  print vu'