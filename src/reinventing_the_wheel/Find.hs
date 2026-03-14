module Find (find') where

find' :: (a -> Bool) -> [a] -> Maybe a
find' _ [] = Nothing
find' p (x : xs)
  | p x = Just x
  | otherwise = find' p xs

main :: IO ()
main = do
  -- findはMaybeを返すのでcaseでデフォルト値を設定する。また、Trueが出たら止まるので要素を1つだけ探す場合には、mapやfilterよりも計算量を抑えられる。
  let oneParent = case find' (\(_, children) -> 1 `elem` children) [(0, [1, 2, 3]), (1, [4, 5, 6])] of
        Just (p, _) -> p
        Nothing -> -1
  print oneParent
