{-# LANGUAGE FlexibleContexts #-}

import Control.Monad.ST
import Data.Array.ST
import Data.ByteString.Char8 qualified as BS
-- import qualified Data.ByteString.Char8 as BS -- AOJ
import Data.Char (digitToInt)

-- 文字を数値(0-3)に変換
charToInt :: Char -> Int
charToInt 'A' = 1
charToInt 'C' = 2
charToInt 'G' = 3
charToInt 'T' = 4
charToInt _ = 0

-- 文字列を独自の数値キーに変換 (4進数のような計算)
-- 文字列の長さが最大12なので、5^12 ≒ 2.4億。
-- メモリ効率のため、各文字に1〜4を割り当て、重みを付けて加算します。
-- "A" -> 1
-- "AA" -> 1 * 5 + 1 = 6
-- "AAA" -> 1 * 5^2 + 1 * 5 + 1 = 31
-- "ACG" -> 1 * 5^2 + 2 * 5 + 3 = 38
strToKey :: BS.ByteString -> Int
strToKey = BS.foldl' (\acc c -> acc * 5 + charToInt c) 0

main :: IO ()
main = BS.interact $ \input ->
  let (_ : lines) = BS.lines input
   in BS.unlines $ runST $ do
        dict <- newArray (0, 244140625) False :: ST s (STUArray s Int Bool)

        let go [] acc = return (reverse acc)
            go (line : rest) acc = do
              let (cmd, restLine) = BS.break (== ' ') line
                  str = BS.tail restLine
                  key = strToKey str

              if cmd == BS.pack "insert"
                then do
                  writeArray dict key True
                  go rest acc
                else do
                  found <- readArray dict key
                  let res = if found then BS.pack "yes" else BS.pack "no"
                  go rest (res : acc)

        go lines []
