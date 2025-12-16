import Control.Arrow ((>>>))
import Control.Monad.ST (ST, runST)
import Data.Array
import Data.Array.ST
import Debug.Trace

-- Data.Arrayを使うバージョン
solve :: Int -> [[Int]]
solve n = runST $ do
  arr <- newArray ((0, 0), (n - 1, n - 1)) 0 :: ST s (STArray s (Int, Int) Int) -- 最小indexは(0,0)、最大index(n-1,n-1)の二次元配列を作る
  -- debug用
  debugArr <- freeze arr
  traceM $ show (elems debugArr) -- [0,0,0,0,0,0,0,0,0]
  let startC = (n - 1) `div` 2 -- cの初期値
  let go r c k
        | k > n * n = return ()
        | otherwise = do
            writeArray arr (r, c) k
            let r' = (r - 1) `mod` n
                c' = (c + 1) `mod` n
            v <- readArray arr (r', c')
            if v == 0
              then go r' c' (k + 1)
              else go ((r + 1) `mod` n) c (k + 1) -- r'

  -- goを呼び出し NOTE: doブロックの中ではletにinを使わないのでin goと書かなくて良い
  go 0 startC 1
  frozen <- freeze arr
  traceM $ show (elems frozen) -- debug [8,1,6,3,5,7,4,9,2]
  return
    [ [ frozen ! (i, j)
        | j <- [0 .. n - 1]
      ]
      | i <- [0 .. n - 1]
    ] -- 内包表記でリストに変換

main :: IO ()
main =
  interact $
    (read :: String -> Int) >>> solve >>> map (unwords . map show) >>> unlines