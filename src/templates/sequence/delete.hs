import Data.Foldable (toList)
import Data.Sequence (Seq (..), ViewL (..), ViewR (..), viewl, viewr)
import Data.Sequence qualified as Seq

-- 先頭削除
deleteHead :: Seq a -> Seq a
deleteHead s = case viewl s of
  _ :< rest -> rest
  EmptyL -> s

-- 末尾削除
deleteLast :: Seq a -> Seq a
deleteLast s = case viewr s of
  rest :> _ -> rest
  EmptyR -> s

-- 指定した要素を削除する
deleteValue :: (Eq a) => a -> Seq a -> Seq a
deleteValue x xs = case Seq.findIndexL (== x) xs of
  Nothing -> xs
  Just i -> Seq.deleteAt i xs

main :: IO ()
main = do
  let xs = [1, 2, 3]
  print xs
  let seqXs = Seq.fromList xs -- Sequenceに変換
  print seqXs
  -- 先頭と末尾の要素をO(1)で削除できる
  let seqXs' = deleteLast seqXs -- [1,2 ]
  let seqXs'' = deleteHead seqXs' -- [2]
  let seqXs''' = deleteValue 2 seqXs'' -- []
  -- リストに戻す
  print $ toList seqXs'''