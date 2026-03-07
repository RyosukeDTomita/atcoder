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

-- True Falseの逆転
invert :: Bool -> Bool
invert True = False
invert False = True

yesNo :: Int -> Bool -> String
yesNo volume isPlay = if volume >= 3 && isPlay then "Yes" else "No"

solve :: [Int] -> [String]
solve as = reverse $ go 0 False [] as
  where
    go _ _ result [] = result
    go volume isPlay result (a : rest)
      | a == 1 =
          let volume' = volume + 1
           in go volume' isPlay ((yesNo volume' isPlay) : result) rest
      | a == 2 =
          if volume >= 1
            then
              let volume' = volume - 1
               in go volume' isPlay ((yesNo volume' isPlay) : result) rest
            else
              go 0 isPlay ("No" : result) rest
      | a == 3 =
          let isPlay' = invert isPlay
           in go volume isPlay' ((yesNo volume isPlay') : result) rest
      | otherwise = ["Error"]

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        -- q = (read :: String -> Int) $ head ls
        as = map read $ tail ls :: [Int]
     in (unlines $ solve as)
