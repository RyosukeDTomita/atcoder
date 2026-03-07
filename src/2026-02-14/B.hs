{-# LANGUAGE CPP #-}

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

-- Sに.を追加する
addDot :: Int -> String -> String
addDot maxLengthS s =
  let lengthS = length s
   in if lengthS < maxLengthS
        then addDot maxLengthS (('.' : s) ++ ".") -- NOTE: 再起のなかで++しているのでO(n^2)になり、若干遅い
        else s

solve :: [String] -> [String]
solve ss =
  let maxLengthS = maximum $ map length ss
   in map (addDot maxLengthS) ss

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        n = (read :: String -> Int) $ head ls
        ss = tail ls
     in unlines $ solve ss
