import Data.List (elemIndex, find)
import Data.Maybe (fromJust)

main :: IO ()
main = do
  -- 要素の探索
  let aList = [1, 2, 3]
  let isExist = if 1 `elem` aList then "Yes" else "NO"
  print isExist
  print $ 3 `elemIndex` aList -- 要素のindexを探す
  print $ 4 `elemIndex` aList -- Nothing

  -- findで要素の探索するとMaybe aが変える
  let maybeOne = find (== 1) aList -- Just 1
  print maybeOne
  let maybeTen = find (== 10) aList -- Nothing
  print maybeTen
