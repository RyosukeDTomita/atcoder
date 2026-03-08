{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}

-- {-# OPTIONS_GHC -DATCODER #-}

import Control.Monad (forM)
import Control.Monad.ST (runST)
import Data.ByteString (ByteString)
import Data.ByteString.Char8 qualified as BS
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

-- 同じ値に行き着いた後は結果が同じになるのでcacheを使用する。
solve :: [Int] -> [Int]
solve as = runST $ do
  let n = length as
      av = VU.fromList (0 : as) -- 1-index化
  memo <- VUM.replicate (n + 1) 0 -- cache
  let findRoot i = do
        cached <- VUM.read memo i
        if cached /= 0
          then pure cached
          else
            if av VU.! i == i
              then do
                VUM.write memo i i
                pure i
              else do
                root <- findRoot (av VU.! i)
                VUM.write memo i root
                pure root
  forM [1 .. n] findRoot

main :: IO ()
main =
  BS.interact $ \inputs ->
    let ls = BS.lines inputs
        -- n = readInt $ head ls
        as = map readInt . BS.words $ ls !! 1 :: [Int]
     in BS.unwords (map (BS.pack . show) (solve as)) <> BS.pack "\n"
