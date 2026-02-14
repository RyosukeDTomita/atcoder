{-# LANGUAGE BangPatterns #-}

import Data.List (foldl')

main :: IO ()
main = do
  -- foldl'を使うことでパフォーマンスが向上
  -- print $ foldl (+) 0 [0 .. 10000000] -- 1.89s user 0.46s system 99% cpu 2.361 total
  print $ foldl' (+) 0 [0 .. 10000000] -- 0.26s user 0.05s system 94% cpu 0.328 total

  -- BangPatternsを試す。
  let f !x = 123
  print $ f 3
