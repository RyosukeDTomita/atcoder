-- フィボナッチ数列の計算（再帰定義）
-- NOTE: 計算量的に良くないが再帰の例として作成
fibonacciNumber :: Int -> Int
fibonacciNumber n
  | n == 0 = 0
  | n == 1 = 1
  | otherwise = fibonacciNumber (n - 1) + fibonacciNumber (n - 2)

main :: IO ()
main = do
  -- 0から35までのフィボナッチ数列を生成
  let range = [0 .. 35]
  let fibonacciNumberList = map fibonacciNumber range

  print fibonacciNumberList
