import Control.Arrow ((>>>))

-- 入力のパース用
parse :: [String] -> [(String, [Int])]
parse [] = []
parse (s : rest)
  | s == "-" = [] -- 終了条件
  | otherwise =
      let m = read $ head rest -- シャッフルの回数
          hs = map read (take m (tail rest)) -- シャッフルの配列
          rest' = drop (m + 1) rest -- 次のrest
       in (s, hs) : parse rest'

-- shuffle処理を行う
shuffle :: String -> Int -> String
shuffle card h =
  let (front, back) = splitAt h card
   in back ++ front

solve :: (String, [Int]) -> String
solve (s, hs) = foldl shuffle s hs

main :: IO ()
main =
  interact $
    lines >>> parse >>> map solve >>> unlines