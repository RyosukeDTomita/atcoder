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

solve :: [String] -> String
solve ss = concatMap (show . go) ss
  where
    go :: String -> Int
    go (c : _)
      | c `elem` "abc" = 2
      | c `elem` "def" = 3
      | c `elem` "ghi" = 4
      | c `elem` "jkl" = 5
      | c `elem` "mno" = 6
      | c `elem` "pqrs" = 7
      | c `elem` "tuv" = 8
      | otherwise = 9
    go [] = error "input is not valid"

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        n = (read :: String -> Int) $ head ls
        ss = words $ ls !! 1
     in solve ss ++ "\n"
