import Data.Foldable (toList)
import Data.Sequence qualified as Seq

-- パターンマッチを使い先頭要素を取り出す
headSeq :: Seq.Seq Int -> Int
headSeq (s Seq.:<| rest) = s

-- パターンマッチを使い末尾要素を取り出す。
lastSeq :: Seq.Seq Int -> Int
lastSeq (rest Seq.:|> s) = s

main :: IO ()
main = do
  let seq = Seq.fromList [1, 2, 3]
  print seq
  let originalList = toList seq -- 元に戻すのにはData.Foldableのメソッドなのに注意
  print originalList
  print $ headSeq seq
  print $ lastSeq seq

  let seq' = seq Seq.|> 4 -- 末尾連結
  print seq'
  let seq'' = 0 Seq.<| seq' -- 先頭に連結
  print seq''
