import Data.List (isPrefixOf, nub, sort)
import Data.Ord (comparing)

-- 可能性のある文字列サイズkの文字列tの組み合わせを求める(オーバーラップあり)
substrings :: Int -> String -> [String]
substrings k s
  | length s < k = [] -- 文字列が長過ぎる場合には空リストを返す。
  | otherwise = take k s : substrings k (tail s) -- tailは文字列の先頭要素を除いた文字列を返すため、再帰的にすべてのtの組み合わせのリストを返せる

-- tが出現する回数を求める(オーバーラップあり)
countSubOverlap :: String -> String -> Int
countSubOverlap sub s
  | sub `isPrefixOf` s = 1 + countSubOverlap sub (tail s) -- isPrefixOfは先頭が一致しているか判定する。つまり、sの先頭がsubかどうかを判定している。 substringsと同様に再帰的に関数を呼び出して、カウンタを増やす。
  | otherwise = case s of
      [] -> 0 -- 空文字列は終了
      (_ : xs) -> countSubOverlap sub xs -- 先頭一文字を捨てて再実行

main :: IO ()
main = do
  [n, k] <- map read . words <$> getLine :: IO [Int]
  s <- getLine
  let subList = nub (substrings k s)
  let occurrenceList = map (\t -> (t, countSubOverlap t s)) subList
  let maxCount = maximum (map snd occurrenceList)
  print maxCount
  -- let maxStrings = sort [str | (str, count) <- occurrenceList, count == maxCount] -- occurrenceListをstrとcountに分けて、strでソートし、countの回数でフィルターしている
  let maxStrings = sort $ map fst $ filter (\(_, count) -> count == maxCount) occurrenceList
  putStrLn (unwords maxStrings)