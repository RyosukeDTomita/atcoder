{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
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

solve :: String -> [String] -> String
solve x ss = if result then "Yes" else "No"
  where
    result = any (go seatN) ss
    getSeatN :: Char -> Int
    getSeatN c
      | c == 'A' = 0
      | c == 'B' = 1
      | c == 'C' = 2
      | c == 'D' = 3
      | c == 'E' = 4
      | otherwise = error "input is not valid"
    seatN = getSeatN $ head x -- headでchar変換
    go :: Int -> String -> Bool
    go i s
      | s !! i == 'o' = True
      | otherwise = False

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        [nStr, x] = words $ head ls
        n = (read :: String -> Int) nStr
        ss = drop 1 ls :: [String]
     in (solve x ss) ++ "\n"
