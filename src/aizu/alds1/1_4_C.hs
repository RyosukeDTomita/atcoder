-- Memory Limit Exceededになった例
{-# LANGUAGE OverloadedStrings #-}

import Data.ByteString (ByteString)
import Data.ByteString.Char8 qualified as BS
-- import qualified Data.ByteString.Char8 as BS -- AOJ
import Debug.Trace (traceShowId)

solve :: [[ByteString]] -> [ByteString]
solve commands = go [] [] commands
  where
    go _ display [] = reverse display
    go dict display (cmd : rest)
      | head cmd == "insert" = go (cmd !! 1 : dict) display rest
      | head cmd == "find" = go dict ((find (cmd !! 1) dict) : display) rest
    find word dict = if word `elem` dict then "yes" else "no"

main :: IO ()
main =
  BS.interact $ \inputs ->
    let ls = BS.lines inputs
        -- n = readInt $ head ls
        commands = map BS.words $ tail ls
     in BS.unlines $ solve commands