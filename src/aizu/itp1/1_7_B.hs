solve :: [Int] -> Int
solve [n, x] =
  -- a < b <cの条件は以下のようにして表現する
  let patterns =
        [ (a, b, c)
          | a <- [1 .. n],
            b <- [a + 1 .. n],
            c <- [b + 1 .. n],
            a + b + c == x
        ]
   in length patterns

main :: IO ()
main = interact $ \input ->
  let intList2D = map (map read . words) . lines $ input :: [[Int]]
      nxList = takeWhile (not . all (== 0)) intList2D
      results = map solve nxList
   in unlines $ map show results
