{-# LANGUAGE OverloadedStrings #-}

import Control.Arrow ((>>>))
import Data.ByteString (ByteString)
import Data.ByteString.Char8 qualified as BS
import Data.Char (isUpper)

solve :: ByteString -> ByteString
solve s
  | BS.length s < 2 = wa
  | BS.index s 0 /= 'A' = wa
  | isUpper (BS.index s 1) = wa
  | otherwise = go 2 False
  where
    wa = "WA"
    ac = "AC"
    len = BS.length s
    go i isC
      | i >= len = if isC then ac else wa
      | not isC && BS.index s i == 'C' =
          if i == len - 1 then wa else go (i + 1) True
      | isC && BS.index s i == 'C' = wa
      | isUpper (BS.index s i) && BS.index s i /= 'C' = wa
      | otherwise = go (i + 1) isC

main :: IO ()
main = BS.interact $ solve >>> (`BS.append` BS.pack "\n")
