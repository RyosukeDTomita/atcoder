-- ChatGPTにかいてもらった貪欲法バージョン(これでTLE解決)
import Data.List (sort)

check :: [Int] -> [Int] -> Int -> Bool
check hs bs k = go hs bs 0
  where
    go [] _ cnt = cnt >= k
    go _ [] cnt = cnt >= k
    go (h : hs') (b : bs') cnt
      | h <= b =
          if cnt + 1 == k
            then True
            else go hs' bs' (cnt + 1)
      | otherwise = go (h : hs') bs' cnt

main :: IO ()
main = interact $ \input ->
  let xs = map read (words input) :: [Int]
      n = xs !! 0
      m = xs !! 1
      k = xs !! 2
      hs = sort $ take n $ drop 3 xs
      bs = sort $ take m $ drop (3 + n) xs
   in unlines [if check hs bs k then "Yes" else "No"]
