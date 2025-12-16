{-# LANGUAGE CPP #-}

import Control.Arrow ((>>>))
import Data.List (mapAccumL)
import Data.Set qualified as S
import Debug.Trace

#ifdef ATCODER
debug :: Bool ; debug = False
#else
debug :: Bool ; debug = True
#endif

solve :: Int -> [[Int]]
solve n =
  let s0 = traceShowId (S.singleton (0, n `div` 2), (0, n `div` 2))
      -- 2からn*nまでの数を順番に配置していく
      (_, placements) = mapAccumL step s0 [2 .. n * n]

      -- 状態yxs、途中経過(r, c)
      step (yxs, (r, c)) d =
        let (r1, c1) = ((r - 1) `mod` n, (c + 1) `mod` n)
            (r2, c2) = ((r + 1) `mod` n, c) -- 第二候補
            yx
              | S.notMember (r1, c1) yxs = (r1, c1)
              | otherwise = (r2, c2)
            yxs' = S.insert yx yxs
         in ((yxs', yx), (yx, d))

      -- 最初のマス (0, n `div` 2) に 1 を配置
      allPlacements = ((0, n `div` 2), 1) : placements

      -- 配置情報からグリッドを構築
      grid = [[0 | _ <- [0 .. n - 1]] | _ <- [0 .. n - 1]]
      updateGrid g (pos, val) =
        [ [ if (i, j) == pos then val else g !! i !! j
            | j <- [0 .. n - 1]
          ]
          | i <- [0 .. n - 1]
        ]
      resultGrid = foldl updateGrid grid allPlacements
   in resultGrid

main :: IO ()
main =
  interact $
    (read :: String -> Int) >>> solve >>> map (unwords . map show) >>> unlines