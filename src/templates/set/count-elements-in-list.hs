import Data.Set qualified as Set

main :: IO ()
main = do
  let aList = [0 ..]
  let bList = [1, 2, 3, 4]
  let bSet = Set.fromList bList
  print $ filter (`Set.member` bSet) aList -- aListの中にあるbListの要素は[1,2,3,4]
  print $ (length . filter (`Set.member` bSet)) aList -- 個数を求める問題もあるので