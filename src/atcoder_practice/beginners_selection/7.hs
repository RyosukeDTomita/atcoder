import Data.List (sortOn)
import Data.Ord (Down (..))

-- aliceが先にカードを引くので降順で偶数のindexの合計、bobはaliceの後にカードを引くので降順で奇数のindexの合計
solve :: [Int] -> Int
solve as =
  let aliceCardSum =
        [ as !! n
          | n <- [0 .. ((length as) - 1)],
            even n
        ]
      bobCardSum =
        [ as !! n
          | n <- [0 .. ((length as) - 1)],
            odd n
        ]
   in sum aliceCardSum - sum bobCardSum

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs -- 一旦全体をlsで受け取る
      n = read (head ls) :: Int -- lsの冒頭
      as = sortOn Down $ map read . words $ (ls !! 1) :: [Int] -- 残りを降順ソート
   in show (solve as) ++ "\n"
