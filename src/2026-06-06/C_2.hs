{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wunused-imports #-}

-- {-# OPTIONS_GHC -DATCODER #-}
import Data.ByteString.Char8 qualified as BS
import Data.IntSet qualified as IntSet
import Data.List (foldl', sortBy)
import Data.Ord (Down (..), comparing)

-- ByteString版 read
readInt :: BS.ByteString -> Int
readInt bs =
  case BS.readInt bs of
    Just (x, _) -> x
    Nothing -> error "input is not integer"

-- |
-- "C V" の1行を(色, 価値)のタプルに変換する
readPair :: BS.ByteString -> (Int, Int)
readPair l =
  case map readInt (BS.words l) of
    [c, v] -> (c, v)
    _ -> error "expected two integers"

-- |
-- k: 選べる宝石の数
-- m: 必要な色の種類数
-- cvs: (色, 価値)のリスト
solve :: Int -> Int -> [(Int, Int)] -> Int
solve k m cvs = baseSum - removeSum + addSum
  where
    sorted = sortBy (comparing (Down . snd)) cvs -- 価値の降順
    (selected, rest) = splitAt k sorted -- 上位K個と残り

    -- 上位K個を1パスで振り分ける(IntSetでO(log n)判定、(++)は使わない)
    --   色の初出 -> keeper(色集合へ), 既出 -> extra(捨てる候補)
    -- extras はconsで積むので昇順(小さい順)になる
    (baseSum, selectedColors, extras) = foldl' classify (0, IntSet.empty, []) selected
    classify :: (Int, IntSet.IntSet, [Int]) -> (Int, Int) -> (Int, IntSet.IntSet, [Int])
    classify (!bs, seen, exs) (c, v)
      | c `IntSet.member` seen = (bs + v, seen, v : exs) -- extra
      | otherwise = (bs + v, IntSet.insert c seen, exs) -- keeper
    need = m - IntSet.size selectedColors -- 追加で必要な色数(0以下ならスワップ不要)

    -- 捨てる: 小さいextraを need 個
    removeSum = sum (take need extras)

    -- 入れる: 残りを降順走査し、未選択色の初出(=その色の最大)を need 個まで貪欲に加算
    (_, addSum, _) = foldl' pick (IntSet.empty, 0, 0) rest
    -- taken: 今回追加で取得した色
    -- acc: 今回追加した宝石の価値の合計
    -- cnt: 追加した個数
    pick :: (IntSet.IntSet, Int, Int) -> (Int, Int) -> (IntSet.IntSet, Int, Int)
    pick (taken, !acc, !cnt) (c, v)
      | cnt >= need = (taken, acc, cnt) -- 必要数に達したら加算しない --NOTE: ==ではなく、>=なのはneedが負になる可能性もあるため。
      | c `IntSet.member` selectedColors = (taken, acc, cnt) -- 既に選択済みの色は何もしない
      | c `IntSet.member` taken = (taken, acc, cnt) -- この新色は最大採用済み
      | otherwise = (IntSet.insert c taken, acc + v, cnt + 1) -- candidate採用

main :: IO ()
main = BS.interact $ \inputs ->
  let ls = BS.lines inputs
      [n, k, m] = map readInt . BS.words $ head ls :: [Int]
      cvs = map readPair (take n (drop 1 ls)) :: [(Int, Int)]
   in BS.pack (show (solve k m cvs)) <> "\n"
