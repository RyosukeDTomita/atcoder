-- ListをData.Setに置き換えて高速化したが、Memory limit Exceeded
{-# LANGUAGE OverloadedStrings #-}

import Data.ByteString (ByteString)
import Data.ByteString.Char8 qualified as BS
import Data.Set qualified as Set

-- import qualified Data.Set as Set -- AOJ
-- import qualified Data.ByteString.Char8 as BS -- AOJ

solve :: [[ByteString]] -> [ByteString]
solve commands = go Set.empty [] commands
  where
    go _ display [] = reverse display
    go dict display (cmd : rest)
      | head cmd == "insert" = go (Set.insert (cmd !! 1) dict) display rest
      | head cmd == "find" = go dict ((find (cmd !! 1) dict) : display) rest
    find word dict = if Set.member word dict then "yes" else "no"

main :: IO ()
main =
  BS.interact $ \inputs ->
    let ls = BS.lines inputs
        -- n = readInt $ head ls
        commands = map BS.words $ tail ls
     in BS.unlines $ solve commands