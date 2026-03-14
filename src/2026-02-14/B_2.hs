-- B.hsよりも自然な発想な気はする。速度も速い。
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

-- サイズnに対応した「.」を生成する
-- NOTE: 両サイドに「.」はつくため、`div` 2している
createDot :: Int -> String -> String
createDot n s = replicate ((n - length s) `div` 2) '.'

solve :: [String] -> [String]
solve ss =
  let maxLengthS = maximum $ map length ss
   in map (\s -> (createDot maxLengthS s) ++ s ++ (createDot maxLengthS s)) ss

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        n = (read :: String -> Int) $ head ls
        ss = tail ls
     in unlines $ solve ss
