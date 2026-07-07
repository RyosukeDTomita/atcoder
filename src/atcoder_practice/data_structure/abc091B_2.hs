-- https://atcoder.jp/contests/abc091/tasks/abc091_b
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Data.Map qualified as Map

solve :: [String] -> [String] -> Int
solve ss ts = maximum $ 0 : Map.elems counts -- 青+1赤-1を集計。候補に0を混ぜるので、全て負(存在しないカードを言う)なら0円になる
  where
    counts = Map.fromListWith (+) $ [(s, 1) | s <- ss] ++ [(t, -1 :: Int) | t <- ts]

main :: IO ()
main =
  interact $ \inputs ->
    let ls = lines inputs
        n = (read :: String -> Int) $ head ls
        (ss, rest) = splitAt n $ tail ls
        (_m : ts) = rest
     in show (solve ss ts) ++ "\n"
