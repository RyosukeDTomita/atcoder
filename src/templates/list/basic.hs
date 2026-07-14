import Data.List (find)
main :: IO ()
main = do
  -- 要素の探索
  let aList = [1, 2, 3]
  let isExist = if 1 `elem` aList then "Yes" else "NO"
  print isExist

  -- findで要素の探索するとMaybe aが変える
  let maybeOne = find (==1) aList -- Just 1
  print maybeOne
  let maybeTen = find (==10) aList -- Nothing
  print maybeTen
