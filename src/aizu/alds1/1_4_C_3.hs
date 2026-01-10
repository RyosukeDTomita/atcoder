-- ListをData.Setに置き換えて高速化したが、Memory limit Exceeded(foldl'バージョン)
{-# LANGUAGE OverloadedStrings #-}

import Data.ByteString (ByteString)
import Data.ByteString.Char8 qualified as BS
-- import Data.ByteString.Char8 qualified as BS -- AOJ
import Data.List (foldl')
import Data.Set qualified as Set

-- import Data.Set qualified as Set -- AOJ

solve :: [[ByteString]] -> [ByteString]
solve commands = reverse display
  where
    (_, display) = foldl' go (Set.empty, []) commands
    go (dict, display) cmd
      | head cmd == "insert" = (Set.insert (cmd !! 1) dict, display)
      | head cmd == "find" = (dict, find (cmd !! 1) dict : display)
      | otherwise = (dict, display)
    find word dict = if Set.member word dict then "yes" else "no"

main :: IO ()
main =
  BS.interact $ \inputs ->
    let ls = BS.lines inputs
        -- n = readInt $ head ls
        commands = map BS.words $ tail ls
     in BS.unlines $ solve commands