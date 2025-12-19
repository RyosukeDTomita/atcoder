-- runCommand !seqXsで!を使う
{-# LANGUAGE BangPatterns #-}
-- "insert"等をByteStringとして解釈させる
{-# LANGUAGE OverloadedStrings #-}

import Data.ByteString qualified as Bs
-- import qualified Data.ByteString as Bs -- AOJだとこっちを使わないといけない
import Data.ByteString.Char8 qualified as BS
-- import qualified Data.ByteString.Char8 as BS -- AOJだとこっちを使わないといけない。
import Data.Foldable (foldl', toList)
import Data.Sequence (Seq, ViewL (..), ViewR (..))
import Data.Sequence qualified as Seq

-- import qualified Data.Sequence as Seq -- AOJだとこっちを使わないといけない

deleteHead :: Seq a -> Seq a
deleteHead s = case Seq.viewl s of
  _ :< rest -> rest
  EmptyL -> s

deleteLast :: Seq a -> Seq a
deleteLast s = case Seq.viewr s of
  rest :> _ -> rest
  EmptyR -> s

deleteValue :: Int -> Seq Int -> Seq Int
deleteValue x xs =
  case Seq.findIndexL (== x) xs of
    Nothing -> xs
    Just i -> Seq.deleteAt i xs

solve :: [[Bs.ByteString]] -> [Int]
solve commands = toList $ foldl' runCommand Seq.Empty commands -- foldlだとメモリオーバーになった。

-- -- NOTE: Memory Limit Exceededになった
-- runCommand :: Seq Int -> [String] -> Seq Int
-- runCommand seqXs [commandName, x]
--   | commandName == "insert" = (read :: String -> Int) x Seq.<| seqXs
--   | commandName == "delete" = deleteValue ((read :: String -> Int) x) seqXs
-- runCommand seqXs [commandName]
--   | commandName == "deleteFirst" = deleteHead seqXs
--   | commandName == "deleteLast" = deleteLast seqXs

runCommand :: Seq Int -> [BS.ByteString] -> Seq Int
runCommand !seqXs line =
  case line of
    ["insert", x] ->
      let Just (v, _) = BS.readInt x
       in v Seq.<| seqXs
    ["delete", x] ->
      let Just (v, _) = BS.readInt x
       in deleteValue v seqXs
    ["deleteFirst"] ->
      deleteHead seqXs
    ["deleteLast"] ->
      deleteLast seqXs
    _ ->
      seqXs

main :: IO ()
main = BS.interact $ \input ->
  let ls = BS.lines input
      (_n : cmds) = ls
      commands = map BS.words cmds
      result = solve commands
   in BS.unwords (map (BS.pack . show) result) <> BS.pack "\n"
