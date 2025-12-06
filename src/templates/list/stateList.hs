import Data.List (mapAccumL)

main :: IO ()
main = do
  -- iterateは関数を繰り返す
  print $ take 10 $ iterate (+ 3) 0 -- 等差数列
  print $ scanl (\_ acc -> acc + 3) 0 [0 .. 10] -- scanlでもかけるけど複雑。[0..10]がループカウンタとして機能している。
  print $ scanl (+) 0 $ replicate 10 3 -- scanlでもかけるけど複雑な例その2 replicateで[3,3,3...]を作って足している。

  -- mapAccumLを使わなくてもscanlで同じようなことができる例
  print $ scanl (+) 0 [1 .. 10] -- [0,1,3,6,10,15,21,28,36,45,55]
  print $ mapAccumL (\acc x -> (acc + x, acc)) 0 [1 .. 10] -- (55,[0,1,3,6,10,15,21,28,36,45])

  -- 状態は合計を出すが、出力は2倍したものを並べるみたいなことはmapAccumLを使わないとできない
  print $ mapAccumL (\acc x -> (acc + x, x * 2)) 0 [1 .. 10] -- (55,[2,4,6,8,10,12,14,16,18,20]) x * 2が結果としてリストに保持される