import Data.List (sort)

-- 最大りんごが何個かごに入れられるかもとめる。
main :: IO ()
main = do
  let limit = 10 -- かごの耐荷重量
  let apples = [1, 1, 3, 10, 2, 4] -- りんごの重さ
  print $ takeWhile (<= limit) $ scanl1 (+) $ sort apples -- りんごを追加した後のかごの重さの変化
  print $ length $ takeWhile (<= limit) $ scanl1 (+) $ sort apples -- りんごを追加した数=りんごの数
  print $ last $ takeWhile (<= limit) $ scanl1 (+) $ sort apples -- 最終的なかごの重さ
  print $ (\a -> (length a, last a)) $ takeWhile (<= limit) $ scanl1 (+) $ sort apples -- 両方出力するなら