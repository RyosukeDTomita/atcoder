-- 解けなかったやつ
{-# LANGUAGE CPP #-}

import Data.List (foldl')
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

solve :: String -> [Int]
solve crossSection = snd $ go ((0, 0.0), []) crossSection
  where
    go :: ((Int, Double), [Int]) -> String -> ((Int, Double), [Int])
    go state [] = state
    go ((depth, nowArea), areas) (c : rest)
      | c == '\\' = go ((depth + 1, nowArea + 0.5 + fromIntegral depth), areas) rest
      | c == '_' = go ((depth, nowArea + fromIntegral depth), areas) rest
      | c == '/' && depth /= 1 = go ((depth - 1, nowArea + 0.5 + fromIntegral depth - 1), areas) rest
      | c == '/' && depth == 1 =
          let nowArea' = nowArea + 0.5
           in go ((0, 0), floor nowArea' : areas) rest

main :: IO ()
main =
  interact $ \inputs ->
    let result = solve $ takeWhile (/= '\n') inputs
        sumArea = sum result
        numPuddle = length result
     in show sumArea ++ "\n" ++ show numPuddle ++ " " ++ unwords (map show result) ++ "\n"