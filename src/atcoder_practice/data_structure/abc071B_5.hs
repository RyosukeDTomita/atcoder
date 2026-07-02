-- https://atcoder.jp/contests/abc071/tasks/abc071_b
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Control.Arrow ((>>>))
import Data.Set qualified as Set

-- アルファベット全体からSに含まれる文字を引き、残りの最小値を返す。空ならNone
solve :: String -> String
solve s = maybe "None" (: []) $ Set.lookupMin $ Set.difference alphabet (Set.fromList s) -- (: [])でcharを文字列に
  where
    alphabet = Set.fromList ['a' .. 'z']

main :: IO ()
main =
  interact $
    lines >>> head >>> solve >>> (++ "\n") -- 入力値側で改行を削除
