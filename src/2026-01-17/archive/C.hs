-- 問題文勘違いしてた
{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}

-- {-# OPTIONS_GHC -DATCODER #-}
import Data.ByteString (ByteString)
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

-- n: カップの総数
-- k: 酒の入っているカップの個数
-- x: 高橋くんが飲む必要のある酒の量
-- as: コップの液体の量
-- n - k杯飲めば次は確実に酒入り
-- asを小さい順にsortしたas'のうち、n-k +1番目から順番に飲ませていき、xを超えたところで止めるのが最悪ケース
solve :: Int -> Int -> Int -> [Int] -> Int
solve n k x as =
  let as' = sort as
      (was, nas) = splitAt k as' -- 最悪ケースでの水と日本酒に分離
      i = fst $ go (0, 0) nas
   in if i >= 0 then (length was) + i else -1
  where
    -- i: 飲んだ酒コップの数
    -- drank: 飲んだ量
    go (i, drank) [] = (-1, -1) -- 酒が足りないのでエラー値
    go (i, drank) (a : as)
      | x > drank' = go ((i + 1), drank') as
      | otherwise = ((i + 1), drank)
      where
        drank' = drank + a

main :: IO ()
main =
  BS.interact $ \inputs ->
    let ls = BS.lines inputs
        [n, k, x] = map readInt . BS.words $ head ls
        as = map readInt . BS.words $ ls !! 1 :: [Int]
     in (BS.pack . show) (solve n k x as) <> BS.pack "\n"