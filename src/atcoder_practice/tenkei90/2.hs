import Control.Arrow ((>>>))

gen :: Int -> Int -> String -> [String]
-- open: `(`を置くことができる数
-- close: `)`を置くことができる数
-- e.g. k = 4つまり、n=2の時
--                                                      addOpen = []
--                                                     /
--                                 addOpen=gen 0 2 "(("                        addOpen=[]
--                                /                    \                      /
--             addOpen=gen 1 2 "("                      addClose=gen 0 1 "(()"
--              /                \                                addOpen=[]  \
--             /                 \                                      /     \
--            /                  \                 addOpen=gen 0 1 "()("      \
-- gen 2 2 ""                    \                       /             \      addClose=gen 0 0 "(())" -- 終了条件
--            \                  \                      /              \
--            \                  \                     /               \
--            \                  \                    /                addClose=gen 0 0 "()()" -- 終了条件
--            \                  addClose=gen 1 1 "()"
--             addClose = []                        \
--                                                  addClose=[]
-- 再帰が巻き戻り、gen 2 2 "" = addOpen=gen 12 "(" = "()()" ++ "(())"
-- ["()()", "(())"]
gen 0 0 s = [s]
gen open close s =
  let addOpen =
        -- `(`がおける場合には置く
        if open > 0
          then
            gen (open - 1) close (s ++ "(")
          else []
      addClose =
        -- `)`がおける場合には置く
        if close > open && close > 0
          then
            gen open (close - 1) (s ++ ")")
          else []
   in addOpen ++ addClose

solve :: Int -> [String]
solve n
  | odd n = [] -- 奇数の場合にはなにも返さない
  | otherwise =
      let k = n `div` 2 -- kは偶数である
       in gen k k ""

main :: IO ()
main =
  interact $
    (read :: String -> Int) >>> solve >>> unlines
