import Data.List (mapAccumL)

main :: IO ()
main = do
  -- これはscanlで同じようなことができる
  print $ scanl (+) 0 [1 .. 10] -- [0,1,3,6,10,15,21,28,36,45,55]
  print $ mapAccumL (\a b -> (a + b, a)) 0 [1 .. 10] -- (55,[0,1,3,6,10,15,21,28,36,45])

  -- 状態は合計を出すが、出力は2倍したものを並べるみたいなことはmapAccumLを使わないとできない
  print $ mapAccumL (\acc x -> (acc + x, x * 2)) 0 [1 .. 10] -- (55,[2,4,6,8,10,12,14,16,18,20])