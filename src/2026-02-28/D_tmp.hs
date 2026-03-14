{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}

-- {-# OPTIONS_GHC -DATCODER #-}

import Control.Monad.ST (runST)
import Data.ByteString (ByteString)
import Data.ByteString.Char8 qualified as BS
import Data.Char (ord)
import Data.List (foldl')
import Data.Map qualified as Map
import Data.Vector.Unboxed qualified as VU
import Data.Vector.Unboxed.Mutable qualified as VUM
import Debug.Trace (traceShowId)

#ifdef ATCODER
debug :: Bool ; debug = False
#else
debug :: Bool ; debug = True
#endif

dbgId :: (Show a) => a -> a
dbgId x
  | debug = traceShowId x
  | otherwise = x

readInt :: BS.ByteString -> Int
readInt bs =
  case BS.readInt bs of
    Just (x, _) -> x
    Nothing -> error "input is not integer"

-- frequencyBS :: BS.ByteString -> VU.Vector Int
-- frequencyBS bs = runST $ do
--   v <- VUM.replicate 256 0
--   BS.foldl' (\acc w -> acc >> VUM.modify v (+ 1) (ord w)) (return ()) bs
--   VU.freeze v

check :: BS.ByteString -> Int -> Bool
check bs i = case BS.uncons bs of
  Nothing -> False
  Just (s, rest)
    | s == 'a' -> check rest 1
    | s == 'b' && i == 1 -> check rest 2
    | s == 'c' && i == 2 -> True
    | otherwise -> check (BS.cons s rest) i

solve :: BS.ByteString -> Int
solve s = loop s 0
  where
    loop bs !n = case check bs 0 of
      Nothing -> n
      Just rest -> loop rest (n + 1)

main :: IO ()
main =
  BS.interact $ \s ->
    (BS.pack . show) (solve (BS.init s)) <> BS.pack "\n"
