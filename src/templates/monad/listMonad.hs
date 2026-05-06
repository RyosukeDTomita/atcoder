-- List Monad: 3つの書き方

import Control.Monad (guard)

-- 例: [1,2,3] と [10,20] の全組み合わせを (x, y) のペアで返す

-- 1. >>= を直接使う
bindStyle :: [(Int, Int)]
bindStyle =
  [1, 2, 3] >>= \x ->
    [10, 20] >>= \y ->
      return (x, y)

-- 2. do 式
doStyle :: [(Int, Int)]
doStyle = do
  x <- [1, 2, 3]
  y <- [10, 20]
  return (x, y)

-- 3. リスト内包表記
listCompStyle :: [(Int, Int)]
listCompStyle = [(x, y) | x <- [1, 2, 3], y <- [10, 20]]

-- guard を使うフィルタ例: x + y が奇数のペアのみ
-- guard False = [] (失敗 = 結果なし), guard True = [()] (成功 = 続行)

-- >>= + guard
bindWithGuard :: [(Int, Int)]
bindWithGuard =
  [1, 2, 3] >>= \x ->
    [10, 20] >>= \y ->
      -- NOTE: guardを使うことで、モナド文脈のまま条件フィルタを行える。
      -- guard True = pure (), guard False = empty
      -- pureとは値を型の文脈にリフトする関数。pure 1 :: Maybe IntはJust 1になる。
      -- NOTE: pureは型変換ではなく、wrapのイメージらしい。pureは値自体を変えずに箱に入れる。
      guard (odd (x + y)) -- NOTE: 型推論により、x,yが[Int]のためリストモナドであることがわかるため、Trueの場合にはpure () :: [()]と同じ動きになり、[()]が返される。
        >> return (x, y)

-- do + guard
doWithGuard :: [(Int, Int)]
doWithGuard = do
  x <- [1, 2, 3]
  y <- [10, 20]
  guard (odd (x + y))
  return (x, y)

-- リスト内包表記 + フィルタ
listCompWithGuard :: [(Int, Int)]
listCompWithGuard =
  [ (x, y)
    | x <- [1, 2, 3],
      y <- [10, 20],
      odd (x + y)
  ]

main :: IO ()
main = do
  -- [(1,10),(1,20),(2,10),(2,20),(3,10),(3,20)]
  print bindStyle
  print doStyle
  print listCompStyle

  -- [(1,10),(1,20),(3,10),(3,20)]
  print bindWithGuard
  print doWithGuard
  print listCompWithGuard
