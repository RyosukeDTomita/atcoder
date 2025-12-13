import Data.Foldable (toList)
import Data.Sequence qualified as Seq

main :: IO ()
main = do
  let xs = [1, 2, 3]
  print xs
  let seqXs = Seq.fromList xs -- Sequenceに変換
  print seqXs
  -- 末尾と先頭にO(1)で要素を挿入できる
  print $ seqXs Seq.|> 4
  print $ 0 Seq.<| seqXs
  -- リストに戻す
  print $ toList seqXs