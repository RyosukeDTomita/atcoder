import Data.List (find, permutations)

main :: IO ()
main = do
  -- findはMaybeを返すのでcaseでデフォルト値を設定する。また、Trueが出たら止まるので要素を1つだけ探す場合には、mapやfilterよりも計算量を抑えられる。
  let oneParent = case find (\(_, children) -> 1 `elem` children) [(0, [1, 2, 3]), (1, [4, 5, 6])] of
        Just (p, _) -> p
        Nothing -> -1
  print oneParent

  -- findを使うことで、条件を満たすものが見つかった時点で再帰を止められるのが嬉しい
  let as = [1, -1, -1, 2, 3]
      valid :: [Int] -> Bool
      valid p = and [a == -1 || p_i == a | (p_i, a) <- zip p as] -- andで全部Trueの時だけTrueを返す
      result = case find valid (permutations [1 .. 5]) of
        Nothing -> "No"
        Just p -> "Yes" ++ unwords (map show p)
  print result
