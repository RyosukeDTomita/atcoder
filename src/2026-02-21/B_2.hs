-- https://atcoder.jp/contests/abc446/submissions/73475891 を参考に作成
{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}

import Data.List (foldl', mapAccumL, uncons)
import Data.Text.Internal.Fusion (reverseStream)
import Debug.Trace (traceShowId)

-- {-# OPTIONS_GHC -DATCODER #-}
#ifdef ATCODER
debug :: Bool ; debug = False
#else
debug :: Bool ; debug = True
#endif

dbgId :: (Show a) => a -> a
dbgId x
  | debug = traceShowId x
  | otherwise = x

-- m: ジュースの種類
-- xss: ジュースの希望リスト
-- B.hsでは、選択されていないジュースのリストを管理していたが、B_2.hsでは選択されたジュースのリストを持つことで、ジュースが選ばれているかどうかのチェックがめちゃくちゃ楽になる。
solve :: Int -> [[Int]] -> [Int]
solve m xss =
  let alreadyPicked = [] -- 選ばれたジュースのリスト。NOTE:  Data.IntSetを使うほうがO(1)に近い計算量で要素を探せて高速だが、本実装ではやらない
   in snd $ mapAccumL go alreadyPicked xss -- 単純にmapするだけだと、各要素に対して同じ関数を適用するだけである。しかし、mapAccumeLを使うと(保存したい状態, 結果)のようにして状態を保存できるため、前回の状態を考慮したmapが行える。
  where
    go :: [Int] -> [Int] -> ([Int], Int)
    go ap xs = case uncons xs' of
      Nothing -> (ap, 0)
      Just (x, _) -> (x : ap, x) -- NOTE: xs'には選ばれていないジュースしかないので選ばれたジュースかどうか確認する必要がなくなっている
      where
        xs' = dropWhile (`elem` ap) xs -- すでに選ばれたジュースを希望リストから削除する。

parse :: [String] -> [[Int]]
parse [] = []
parse (l : xs : rest) = (map (read :: String -> Int) . words $ xs) : parse rest

main :: IO ()
main =
  interact $ \inputs ->
    let linesInput = lines inputs
        [n, m] = map read . words $ head linesInput :: [Int]
        !ls = parse $ tail linesInput
     in unlines (map show (solve m ls))
