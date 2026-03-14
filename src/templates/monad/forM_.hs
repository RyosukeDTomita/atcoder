import Control.Monad (forM, forM_)

main :: IO ()
main = do
  let xs = [1, 2, 3, 4]

  -- forM_は結果を返さなくて良い
  forM_ xs $ \x -> do
    let x2 = x * 2
    print x
    print x2

  -- forMは結果を返すので受け取る変数が必要になる
  results <- forM xs $ \x -> do
    let x2' = x * 2
    print x
    print x2'
    pure x2' -- 返す値
  print results
