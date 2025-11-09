import Data.List (scanl')

-- 各クエリに応じて重量とパーツの状態を更新する関数
step :: [Int] -> (Int, [Bool]) -> Int -> (Int, [Bool])
step wList (currentWeight, isPartsAttachedList) query =
  let i = query - 1
      w = wList !! i
      isAttached = isPartsAttachedList !! i
      -- パーツが取り付けられているかの情報を更新
      newIsAttached = not isAttached
      newIsPartsAttachedList = take i isPartsAttachedList ++ [newIsAttached] ++ drop (i + 1) isPartsAttachedList
      newWeight =
        if newIsAttached
          then
            currentWeight + w
          else currentWeight - w
   in (newWeight, newIsPartsAttachedList)

main :: IO ()
main = interact $ \input ->
  let xs = map read (words input) :: [Int]
      x = xs !! 0 -- 初期重量
      n = xs !! 1 -- パーツの種類数
      wList = take n (drop 2 xs) -- 各パーツの重さ
      q = xs !! (2 + n) -- クエリ数
      queries = take q (drop (3 + n) xs) -- とりつけるパーツの番号のリスト
      results = tail $ scanl' (step wList) (x, replicate n False) queries -- scanlは結果に初期値も含むため、tailで初期値を削除している。
   in unlines [show cur | (cur, _) <- results]
