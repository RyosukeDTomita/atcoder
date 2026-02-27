{-# LANGUAGE BangPatterns #-}

main :: IO ()
main = do
  print $ go 0 [1 .. 100000000]
  where
    -- 破壊的更新をするよりも末尾再帰呼出しのほうが良い。
    go !i [] = i
    -- go !i (x : rest) = case even x of
    --   True -> go (i + x) rest
    --   False -> go i rest
    go !i (x : rest)
      | even x = go (i + x) rest
      | otherwise = go i rest
