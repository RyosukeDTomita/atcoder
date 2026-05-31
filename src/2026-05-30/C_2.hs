-- C.hsをもっと関数型ぽくしてもらった
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wunused-imports #-}

-- {-# OPTIONS_GHC -DATCODER #-}
import Data.ByteString.Char8 qualified as BS
import Data.List (foldl', sort)
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

-- as シャリ
-- bs ネタ
-- (作った寿司の数, シャリ全体)を初期状態とする畳み込み
solve :: [Int] -> [Int] -> Int
solve as bs = fst $ foldl' step (0, as') bs'
  where
    -- ネタ y ごとに、足りないシャリ (2*x < y) を読み飛ばし、最初に足りるシャリを1個消費する貪欲法。
    step :: (Int, [Int]) -> Int -> (Int, [Int])
    step (cnt, shari) y =
      case dropWhile (\x -> 2 * x < y) shari of -- ネタyに載せられないシャリ=Trueなのでskip Falseになったところで止まる=先頭のシャリが使用できるシャリ
        (_ : rest) -> (cnt + 1, rest)
        [] -> (cnt, [])
    !as' = dbgId $ sort as
    !bs' = dbgId $ sort bs

main :: IO ()
main =
  BS.interact $ \inputs ->
    let ls = BS.lines inputs
        [n, m] = map readInt . BS.words $ head ls :: [Int]
        as = map readInt . BS.words $ ls !! 1 :: [Int]
        bs = map readInt . BS.words $ ls !! 2 :: [Int]
     in (BS.pack . show) (solve as bs) <> BS.pack "\n"
