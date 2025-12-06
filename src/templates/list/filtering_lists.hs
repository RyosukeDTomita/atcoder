import Data.Char (isSpace)
import Data.List (dropWhileEnd)

main :: IO ()
main = do
  -- filterは条件を満たすものをすべて抽出する
  print $ filter (< 3) [1, 2, 3, 4, 5, 1] -- [1,2,1]

  -- takeWhile条件を満たさないものが出た時点で止まる --> 無限リストを打ち切ることができる
  print $ takeWhile (< 3) [1, 2, 3, 4, 5, 1] -- [1,2]
  print $ takeWhile (< 3) [0 ..] -- [1,2] 無限リストを打ち切れた例

  -- dropWhileはTrueのものを捨てる(Falseが出たらそこで止まり、残りの要素を返す)
  print $ dropWhile (< 3) [1, 2, 3, 4, 5, 1] -- [3,4,5,1]
  -- print $ dropWhile (< 3) [0 ..] -- 0,1,2以降の全てになるので終わらない

  -- dropWhileEndはリストの末尾からいらないものを消す
  print $ dropWhileEnd (== 0) [1, 2, 3, 0, 0, 0]
  print $ takeWhile (/= 0) [1, 2, 3, 0, 0, 0] -- 場合によっては代替できる
  print $ dropWhileEnd isSpace "foo\n " -- foo
