main :: IO ()
main = do
  let array_2d = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]

  -- mapM_ (print . map show) array_2d -- ["1","2","3"]\n["4","5","6"]\n["7","8","9"]
  mapM_ (putStrLn . unwords . map show) array_2d -- unwordsでスペース区切りに戻す
  putStr $ (unlines . map (unwords . map show)) array_2d