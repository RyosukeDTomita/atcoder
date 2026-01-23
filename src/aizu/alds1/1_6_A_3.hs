-- ByteString+Vector化してもMemory Limit Exceeded
{-# LANGUAGE OverloadedStrings #-}

import Control.Monad (forM_)
import Control.Monad.ST (ST, runST)
import Data.Array.ST (STUArray, freeze, newArray, readArray, writeArray)
import Data.Array.Unboxed (UArray, assocs)
import Data.ByteString (ByteString)
import Data.ByteString.Char8 qualified as BS
import Debug.Trace (traceShowId)

readInt :: BS.ByteString -> Int
readInt bs =
  case BS.readInt bs of
    Just (x, _) -> x
    Nothing -> error "input is not integer"

countingSort :: [Int] -> [Int]
countingSort xs = runST $ do
  let lo = minimum xs
      hi = maximum xs
  arr <- newArray (lo, hi) (0 :: Int) :: ST s (STUArray s Int Int)
  forM_ xs $ \x ->
    readArray arr x >>= writeArray arr x . (+ 1)
  frozen <- freeze arr
  let result = frozen :: UArray Int Int
  pure [i | (i, c) <- assocs result, _ <- [1 .. c]]

main :: IO ()
main =
  BS.interact $ \inputs ->
    let ls = BS.lines inputs
        --   n = readInt $ head ls
        !xs = map readInt . BS.words $ ls !! 1 :: [Int]
     in BS.unwords (map (BS.pack . show) (countingSort xs)) <> BS.pack "\n"
