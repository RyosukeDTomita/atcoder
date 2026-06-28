{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

-- {-# OPTIONS_GHC -DATCODER #-}
import Data.ByteString.Char8 qualified as BS
-- import Data.List (foldl')
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

-- 1テストケース
data TestCase = TestCase
  { n :: Int, -- 要素数
    s :: BS.ByteString, -- R/S からなる文字列
    xs :: [Int], -- X1..XN
    ys :: [Int] -- Y1..Y(N-1)
  }

-- 4行ずつ取り出してテストケースに変換する
parse :: [BS.ByteString] -> [TestCase]
parse [] = []
parse (ln : ls : lx : ly : rest) =
  TestCase
    { n = readInt ln,
      s = ls,
      xs = map readInt $ BS.words lx,
      ys = map readInt $ BS.words ly
    }
    : parse rest
parse _ = error "invalid test case format"

solve :: TestCase -> Int
solve _ = undefined

main :: IO ()
main =
  BS.interact $ \inputs ->
    let ls = BS.lines inputs
        _t = readInt $ head ls :: Int -- テストケース数
        cases = parse $ drop 1 ls
     in BS.unlines $ map (BS.pack . show . solve) cases
