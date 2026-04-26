module Group (group') where

-- https://hackage-content.haskell.org/package/ghc-internal-9.1401.0/docs/src/GHC.Internal.Data.OldList.html#group
group' :: (Eq a) => [a] -> [[a]]
group' xs = groupBy' (==) xs

-- eq: 2つの要素が等しいかどうかを判定する関数
groupBy' :: (a -> a -> Bool) -> [a] -> [[a]]
groupBy' _ [] = []
groupBy' eq (x : xs) = (x : ys) : groupBy' eq rest
  where
    (ys, rest) = span' (eq x) xs -- xと値が同じものが出現しなくなったところで止まる
    -- ghci> span (==2) [2, 2, 3,3,3,4,4,4,4]
    -- ([2,2],[3,3,3,4,4,4,4])

-- https://hackage-content.haskell.org/package/ghc-internal-9.1401.0/docs/src/GHC.Internal.List.html#span
span' :: (a -> Bool) -> [a] -> ([a], [a])
span' _ xs@[] = (xs, xs)
span' p xs@(x : rest)
  -- p xがFalseになるまで再起
  | p x =
      let (ys, zs) = span' p rest
       in (x : ys, zs)
  | otherwise = ([], xs)

main :: IO ()
main = do
  print $ group' [1, 2, 2, 3, 3, 3]
