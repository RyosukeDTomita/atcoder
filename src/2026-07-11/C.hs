{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE MonoLocalBinds #-}
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import System.IO (BufferMode (LineBuffering), hSetBuffering, stdout) -- おまじない

-- iとjの距離が1以下かをジャッジに質問する
ask :: Int -> Int -> IO Bool
ask i j = do
  putStrLn $ "? " ++ show i ++ " " ++ show j
  res <- getLine
  pure $ res == "Yes"

solve :: Int -> Int -> Int -> Int -> IO Int
solve n i j result
  | i > n = pure result -- 再帰終了
  | j > n = solve n (i + 1) (max j (i + 2)) (result + (j - i - 1)) -- i..j-1 は距離1以下と確定しているので (j - i - 1)をNoのタイミングでまとめて足す。次回のjは必ずiより大きい必要があるのでi+2とmaxを取る
  | otherwise = do
      res <- ask i j
      if res then solve n i (j + 1) result else solve n (i + 1) (max j (i + 2)) (result + (j - i - 1))

main :: IO ()
main = do
  hSetBuffering stdout LineBuffering -- パイプ経由でもputStrLnごとにflushされる
  n <- readLn :: IO Int
  result <- solve n 1 2 0
  putStrLn $ "! " ++ show result
