{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Debug.Trace (traceShowId)

-- {-# OPTIONS_GHC -DATCODER #-}
#ifdef ATCODER
debug :: Bool ; debug = False
#else
debug :: Bool ; debug = True
#endif

dbgId :: (Show a) => a -> a
dbgId x
  | debug = traceShowId x
  | otherwise = x

-- まず、h1,h2,w1,w2の取りうる値を全列挙する。
-- h1,h2,w1,w2に対して存在する(i, j)を全列挙する。
-- 各(i, j)に対して点対称な位置の色をチェックし、すべての色が等しいならば点対称な図形としてカウントする。
-- NOTE: 中心(x,y)を対象に180度回した場合には、まず、中心に戻すために -x, - yする必要があり、回した後に +x, +yする必要があり、-180度回すと正負が入れ替わるためこのような式になる。
solve :: Int -> Int -> [String] -> Int
solve h w ss = length $ filter isSymmetric candidates
  where
    candidates =
      [ (h1, h2, w1, w2)
        | h1 <- [0 .. h - 1],
          h2 <- [h1 .. h - 1],
          w1 <- [0 .. w - 1],
          w2 <- [w1 .. w - 1]
      ]
    isSymmetric (h1, h2, w1, w2) =
      all
        (\(i, j) -> (ss !! i) !! j == (ss !! (h1 + h2 - i)) !! (w1 + w2 - j))
        [(i, j) | i <- [h1 .. h2], j <- [w1 .. w2]]

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        ![h, w] = map read . words $ head ls :: [Int]
        ss = drop 1 ls :: [String] -- BangPatternsのほうが遅い
     in show (solve h w ss) ++ "\n"
