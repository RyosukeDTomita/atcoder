import Control.Monad
import Control.Monad.ST (ST, runST)
import Data.Array (Array, array, bounds, elems, indices, listArray, (!), (//))
import Data.Array.ST

main :: IO ()
main = do
  -- イミュータブル配列 (Data.Array)
  let arr1 :: Array Int Int
      arr1 = listArray (0, 4) [10, 20, 30, 40, 50] -- インデックス 0~4を事前に指定することでランダムアクセスO(1)を実現している。
  print arr1 -- array (0,4) [(0,10),(1,20),(2,30),(3,40),(4,50)]
  print $ arr1 ! 1 -- 20

  -- ミュータブル配列 (Data.Array.ST)
  -- runSTArray: STモナド内で配列を作成・更新し、最後にイミュータブル配列として返す
  let arr2 :: Array Int Int
      arr2 = runST $ do
        -- newArray (境界) 初期値 で配列を作成
        marr <- newArray (0, 4) 0 :: ST s (STArray s Int Int)
        -- writeArray で要素を更新
        writeArray marr 0 100
        writeArray marr 1 200
        writeArray marr 2 300
        -- forM_ でループして更新することも可能
        forM_ [3, 4] $ \i -> writeArray marr i (i * 10)
        freeze marr -- ミュータブルをイミュータブルにする
        -- NOTE: do記法では最後の式の値がそのまま返り値になるのでreturnは不要。
  print arr2 -- array (0,4) [(0,100),(1,200),(2,300),(3,30),(4,40)]
