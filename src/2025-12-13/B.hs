import Control.Arrow ((>>>))

solve :: Int -> [[Int]]
solve n =
  let startC = (n - 1) `div` 2 -- 最初に埋めるc
      ass =
        [ [ if r == 0 && c == startC then 1 else 0
            | c <- [0 .. n - 1]
          ]
          | r <- [0 .. n - 1]
        ] -- 一旦最初のマスを1でそれ以外を0で埋める
   in go ass 0 startC 1 -- kの初期値は1
  where
    -- r cは添字
    -- kは試行回数でこれでマスを埋めていく
    go ass r c k
      | k >= n * n = ass -- 終了
      | (ass !! r' !! c') == 0 -- 空白なら (r', c') に書き込む
        =
          let ass' =
                take r' ass
                  ++ [ take c' (ass !! r')
                         ++ [k + 1]
                         ++ drop (c' + 1) (ass !! r')
                     ]
                  ++ drop (r' + 1) ass
           in go ass' r' c' (k + 1)
      | otherwise -- 空白でないなら (r+1 mod n, c) に書き込む
        =
          let r'' = (r + 1) `mod` n
              ass' =
                take r'' ass
                  ++ [ take c (ass !! r'')
                         ++ [k + 1]
                         ++ drop (c + 1) (ass !! r'')
                     ]
                  ++ drop (r'' + 1) ass
           in go ass' r'' c (k + 1)
      where
        r' = (r - 1) `mod` n
        c' = (c + 1) `mod` n

main :: IO ()
main =
  interact $
    (read :: String -> Int) >>> solve >>> map (unwords . map show) >>> unlines