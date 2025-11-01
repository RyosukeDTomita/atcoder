-- モナド則1: 左単位元則
-- return a >>= f = f a

f :: Int -> Maybe Int
f x = Just (x + 1)

main :: IO ()
main = do
  -- 左辺: return 3 >>= f
  let leftSide = return 3 >>= f
  putStrLn $ "左辺 (return 3 >>= f): " ++ show leftSide

  -- 右辺: f 3
  let rightSide = f 3
  putStrLn $ "右辺 (f 3): " ++ show rightSide
