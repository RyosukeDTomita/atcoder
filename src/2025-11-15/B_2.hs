-- takeとdropで書くとつらいのでpartitionを使ったバージョン
import Data.Char (digitToInt, intToDigit)
import Data.List (partition, sort)

-- 数字のリストを受け取り、先頭が 0 にならないように調整
solve :: Int -> [Int]
solve x =
  case zeros of
    [] -> sortX -- 0 がない場合はそのままソート
    _ -> nonZero : zeros ++ rest'
  where
    sortX = sort $ map digitToInt $ show x
    (zeros, rest) = partition (== 0) sortX -- 0の要素とそうでない要素で分割
    nonZero = head rest -- 0でない数字でもっとも小さい数字
    rest' = tail rest -- nonZeroを取り出した残り

main :: IO ()
main =
  interact $ \inputs ->
    let x = read inputs :: Int
     in concatMap show (solve x) ++ "\n"