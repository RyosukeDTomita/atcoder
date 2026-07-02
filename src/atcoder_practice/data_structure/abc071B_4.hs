-- https://atcoder.jp/contests/abc071/tasks/abc071_b
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Control.Arrow ((>>>))
import Data.List (find)
import Data.Set qualified as Set

-- Sに含まれない最小の英小文字を返す。全て含む場合はNone
solve :: String -> String
solve s = case find (`Set.notMember` sSet) ['a' .. 'z'] of
  Just c -> [c]
  Nothing -> "None"
  where
    sSet = Set.fromList s

main :: IO ()
main =
  interact $
    lines >>> head >>> solve >>> (++ "\n") -- 入力値側で改行を削除
