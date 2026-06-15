{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wunused-imports #-}
{-# OPTIONS_GHC -Wno-x-partial #-}

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

solve :: Int -> [[Int]] -> [[Int]]
solve n kas =
  [ length bs : bs
  | j <- [1 .. n],
    let bs = receivers j -- プレゼントをくれた人のリスト
  ]
  where
    -- 各人が送った相手リストを作るために先頭だけ捨てる
    sent = map (drop 1) kas
    -- 人(j)にギフトを送った人を昇順に集める(関係の転置)
    receivers :: Int -> [Int]
    receivers j =
      [ i -- くれた人の番号だけ残す
      | (i, dests) <- zip [1 .. n] sent,
        j `elem` dests -- 自分宛てのものだけフィルター
      ]

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      !n = read $ head ls :: Int
      !kas = map (map read . words) $ drop 1 ls :: [[Int]]
   in unlines . map (unwords . map show) $ solve n kas
