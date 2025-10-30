drawRectangle :: [Int] -> String
drawRectangle [h, w] = unlines $ replicate h (replicate w '#')

main :: IO ()
main = do
  input <- map (map read . words) . lines <$> getContents :: IO [[Int]]
  let dataSets = takeWhile (not . all (== 0)) input
  -- mapM_ (putStr . drawRectangle) dataSets -- 直感的だが、改行がない
  mapM_ (\ds -> putStr (drawRectangle ds) >> putStrLn "") dataSets