import Data.List (mapAccumL)

main :: IO ()
main = do
  let orders = [1, 1, 2, 3, 5] :: [Int]
  let result = mapAccumL go [] orders
  print result
  let result2 = go2 [] orders
  print result2
  let result3 = go3 [] orders []
  print result3
  where
    -- 一度選ばれた数字に対しては0を返す。
    go :: [Int] -> Int -> ([Int], Int)
    go selected order =
      if order `elem` selected
        then (selected, 0)
        else (order : selected, order)
    -- mapAccumeLなしバージョン
    go2 :: [Int] -> [Int] -> ([Int], [Int])
    go2 selected [] = (selected, [])
    go2 selected (order : orders) =
      let (newSelected, result) =
            if order `elem` selected
              then (selected, 0)
              else (order : selected, order)
          (finalSelected, results) = go2 newSelected orders
       in (finalSelected, result : results)

    -- mapAccumeLなし3引数バージョン
    go3 :: [Int] -> [Int] -> [Int] -> ([Int], [Int])
    go3 selected [] results = (selected, reverse results)
    go3 selected (order : rest) results =
      if order `elem` selected
        then go3 selected rest (0 : results)
        else go3 (order : selected) rest (order : results)
