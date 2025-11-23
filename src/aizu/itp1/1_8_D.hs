import Data.List (isInfixOf)

-- 文字列s(円状)のなかにパターンpがあるかを判別する
findPattern :: String -> String -> Bool
findPattern s p =
  or -- 1つでもTrueがあればTrueを返す関数
    [ p `isInfixOf` rotate i s
      | i <- [0 .. length p - 1]
    ]
  where
    rotate n xs = drop n xs ++ take n xs -- 冒頭n文字を取り出して、後ろに連結する

solve :: String -> String -> String
solve s p = if findPattern s p then "Yes\n" else "No\n"

main :: IO ()
main = interact $ \input ->
  let ls = lines input
      s = head ls
      p = ls !! 1
   in solve s p