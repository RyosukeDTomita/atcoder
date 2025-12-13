-- Time Limit Exceededになる例
parseProcess :: [String] -> (String, Int)
parseProcess (name : time) = (name, (read :: String -> Int) $ head time) -- headで[time]をtimeにしている

toStringProcess :: (String, Int) -> String
toStringProcess p = fst p ++ " " ++ show (snd p)

solve :: Int -> [(String, Int)] -> [String]
solve q process = go 0 process []
  where
    go _ [] output = map toStringProcess output
    go elapsedTime (p : ps) output
      | q >= snd p -- クオンタムでプロセスが完了する場合
        =
          let elapsedTime' = elapsedTime + snd p
           in go elapsedTime' ps (output ++ [(fst p, elapsedTime')])
      | otherwise =
          let elapsedTime' = elapsedTime + q
              p' = (fst p, snd p - q)
           in go elapsedTime' (ps ++ [p']) output

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      [_, q] = map read . words $ head ls :: [Int]
      process = map (parseProcess . words) $ tail ls
   in unlines $ solve q process