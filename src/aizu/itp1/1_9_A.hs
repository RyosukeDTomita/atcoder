import Data.Char (toLower)

-- wという単語の出現回数をカウントするtsは改行とスペース区切りの文章。
solve :: String -> [[String]] -> Int
solve w ts =
  sum $
    [ length $ filter (== w) t
      | t <- ts
    ]

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      w = head ls
      t = map words $ tail ls
      t' = map (map (map toLower)) t -- 全て小文字に
   in show (solve w t') ++ "\n"