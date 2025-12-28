import Control.Arrow ((>>>))

-- f + 7n > dを満たす最小のnを求め、f + 7n - dを計算すれば曜日が決まる。
-- 変形すると(f - d) + 7n > 0になるので、(f - d) `mod` 7を計算すれば次の日付が求められるはず。
-- この際に1<=f<=7だが、mod 7は0〜6なので-1して後から+1して調整する
--
solve :: [Int] -> Int
solve [d, f] = ((f - 1 - d) `mod` 7) + 1

main :: IO ()
main =
  interact $
    words >>> map (read :: String -> Int) >>> solve >>> show >>> (++ "\n")