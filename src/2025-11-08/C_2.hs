-- ChatGPTにかいてもらった貪欲法バージョン(これでTLE解決)
import Data.List (sort)

-- 前提: hs、bsは昇順でソート済み
check :: [Int] -> [Int] -> Int -> Bool
check hs bs k = go hs bs 0
  where
    go [] _ cnt = cnt >= k
    go _ [] cnt = cnt >= k
    go (h : hs') (b : bs') cnt
      | h <= b =
          if cnt + 1 == k
            then True
            else go hs' bs' (cnt + 1) -- カウントを増やして次の頭とからだパーツを試すため再帰
      | otherwise = go (h : hs') bs' cnt -- 頭よりも体が軽かった場合には頭は変えずに体パーツのindexのみをずらして、より重い体パーツで再帰

main :: IO ()
main = interact $ \input ->
  let xs = map read (words input) :: [Int]
      n = xs !! 0 -- 頭のパーツの数
      m = xs !! 1 -- 体のパーツの数
      k = xs !! 2 -- 作りたい倒れないロボットの数
      hs = sort $ take n $ drop 3 xs -- 頭のパーツの重さリスト
      bs = sort $ take m $ drop (3 + n) xs -- 体パーツの重さリスト
   in unlines [if check hs bs k then "Yes" else "No"]
