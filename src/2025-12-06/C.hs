solve :: [Int] -> Int
solve (1 : rest) = 1 -- 最初の一本目が1の時
solve (a : as) = length $ fst $ fallDown ([a], as)

fallDown :: ([Int], [Int]) -> ([Int], [Int])
fallDown (fall, []) = (fall, []) -- rest が空なら終了
fallDown (fall, rest) =
  let power = maximum $ zipWith (-) fall $ reverse [1 .. length fall] -- 今回の再帰で倒せる数 NOTE: A_i = 1では何も倒せないように最低でも-1されるようにしている。
      (fall', rest') = splitAt power rest
      power' =
        if length fall' /= 0
          then maximum $ zipWith (-) fall' $ reverse [1 .. length fall'] -- 次回の再帰で倒せる数
          else 0
   in if power' >= 1
        then
          fallDown (fall ++ fall', rest')
        else
          (fall ++ fall', rest') -- 今回の結果を更新して終了

-- 1本目のドミノが倒れた時に追加で倒れるドミノはA_i-1本である。
-- 最後に倒れたドミノの影響範囲で再帰すれば良さそう?
main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      n = read $ head ls :: Int
      as = map read . words $ ls !! 1 :: [Int] -- Haskellのリストのインデックスは0スタートなので冒頭に0を追加
   in show (solve as) ++ "\n"