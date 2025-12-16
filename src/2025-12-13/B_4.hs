import Control.Arrow ((>>>))
import Control.Monad.ST (runST)
import Data.Vector qualified as V
import Data.Vector.Mutable qualified as MV
import Debug.Trace

-- Data.Vectorを使うバージョン
-- 2次元配列を1次元に平坦化: (r, c) -> r * n + c NOTE: Vector自体は1次元しかサポートしていない
solve :: Int -> [[Int]]
solve n = runST $ do
  arr <- MV.replicate (n * n) 0 -- n*n の要素を0で初期化
  -- debug用
  debugArr <- V.freeze arr
  traceM $ show (V.toList debugArr) -- [0,0,0,0,0,0,0,0,0]
  let startC = (n - 1) `div` 2 -- cの初期値
  let idx r c = r * n + c -- 2次元 -> 1次元のインデックス変換
  let go r c k
        | k > n * n = return ()
        | otherwise = do
            MV.write arr (idx r c) k
            let r' = (r - 1) `mod` n
                c' = (c + 1) `mod` n
            v <- MV.read arr (idx r' c')
            if v == 0
              then go r' c' (k + 1)
              else go ((r + 1) `mod` n) c (k + 1)

  -- goを呼び出し NOTE: doブロックの中ではletにinを使わないのでin goと書かなくて良い
  go 0 startC 1
  frozen <- V.freeze arr
  traceM $ show (V.toList frozen) -- debug [8,1,6,3,5,7,4,9,2]

  -- 1次元Vectorを2次元リストに変換
  return
    [ [ frozen V.! (idx i j)
        | j <- [0 .. n - 1]
      ]
      | i <- [0 .. n - 1]
    ]

main :: IO ()
main =
  interact $
    (read :: String -> Int) >>> solve >>> map (unwords . map show) >>> unlines