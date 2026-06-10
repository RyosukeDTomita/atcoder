-- 流石にゴリ押しすぎたので変えた。
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

keypad :: [String]
keypad = ["abc", "def", "ghi", "jkl", "mno", "pqrs", "tuv", "wxyz"]

solve :: [String] -> String
solve ss = concatMap (show . digit . head) ss
  where
    digit :: Char -> Int
    digit c =
      head -- 内包表記を崩すためのhead
        [ d
        | (d, g) <-
            zip
              [2 ..]
              keypad,
          c `elem` g
        ]

main :: IO ()
main =
  interact $ \inputs ->
    let ss = words $ lines inputs !! 1
     in solve ss ++ "\n"
