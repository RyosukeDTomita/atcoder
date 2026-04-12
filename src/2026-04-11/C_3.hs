-- 問題の制約的にBSいらない気がするのでStringに戻してみた。Lが長い文字列なのでBSのほうが速い。
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wunused-imports #-}

-- {-# OPTIONS_GHC -DATCODER #-}
import Control.Monad (replicateM)
import Debug.Trace (traceShowId)

#ifdef ATCODER
debug :: Bool ; debug = False
#else
debug :: Bool ; debug = True
#endif

dbgId :: (Show a) => a -> a
dbgId x
  | debug = traceShowId x
  | otherwise = x

solve :: [Int] -> Int
solve ls =
  let ls' = map fromIntegral ls :: [Double]
   in maximum
        [ count 0.5 (zipWith (*) signs ls')
          | signs <- replicateM (length ls') [1, -1]
        ]
  where
    count :: Double -> [Double] -> Int
    count _ [] = 0
    count x (d : ds) =
      let x' = x + d
          c = if (x > 0) /= (x' > 0) then 1 else 0
       in c + count x' ds

main :: IO ()
main =
  interact $ \inputs ->
    let ls' = lines inputs
        !ls = map read . words $ ls' !! 1 :: [Int]
     in show (solve ls) ++ "\n"
