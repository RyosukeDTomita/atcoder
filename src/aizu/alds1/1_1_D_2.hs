-- NOTE: Memory Limit Exceededを避けるために内包表記をやめて、最小の値と利益の最大値だけ持つ
solve :: [Int] -> Int
solve (r : rs) = go rs r (-10 ^ 18) -- NOTE: minVの最小値はとてつもなく小さくしておいたほうが安全
  where
    -- rs: rs
    -- minV: 今まで見た中での最小の価格
    -- bestBenefit: 利益の最大値
    go [] minV bestBenefit = bestBenefit -- 終了条件
    go (r : rs) minV bestBenefit =
      let bestBenefit' = max bestBenefit (r - minV)
          minV' = min minV r
       in go rs minV' bestBenefit'

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      rs = map (read :: String -> Int) $ tail ls
   in show (solve rs) ++ "\n"