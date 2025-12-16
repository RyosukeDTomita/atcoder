-- https://atcoder.jp/contests/abc436/submissions/71669502 を参考に作成
import Data.Set qualified as Set

-- NOTE: 左上の点だけに着目して、それがおけるかどうかだけで解いている。
solve :: [(Int, Int)] -> Int
solve rcs =
  let result = foldl step Set.empty rcs
        where
          step acc (r, c)
            | canPut acc (r, c) = Set.insert (r, c) acc
            | otherwise = acc
   in Set.size result

-- 左上におけるか?
-- 他の左上部分が自身の周囲3マス以内になければおける
canPut :: Set.Set (Int, Int) -> (Int, Int) -> Bool
canPut acc (r, c) =
  -- NOTE* not orで一つでもあったらFalse
  not $
    or
      [ Set.member (r', c') acc
        | r' <- [r - 1 .. r + 1],
          c' <- [c - 1 .. c + 1]
      ]

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      [n, m] = map (read :: String -> Int) . words $ head ls
      rcs =
        [ (r, c)
          | line <- drop 1 ls,
            let [r, c] = map (read :: String -> Int) $ words line
        ]
   in show (solve rcs) ++ "\n"