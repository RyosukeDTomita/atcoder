-- TLEになる例
import Control.Arrow ((>>>))
import Data.List (isSuffixOf)

-- isSuffixOfを使って後ろからwordListにマッチするものがないか探す。
-- NOTE: wordListは大きい順にしておく必要がある。eraserがある時にeraseでマッチすると壊れるから
solve :: String -> Bool
solve "" = True -- 再帰で全ての文字列を消せるならS=T
solve s =
  case filter (`isSuffixOf` s) wordList of -- ここもO(n)なので改善が必要
    [] -> False -- 末尾がマッチしない場合
    (word : _) -> solve (take (length s - length word) s) -- 末尾からword分だけ除去して再帰
    -- NOTE: takeとlengthがO(n)なので再帰が多い場合にはコストがかさむ。wordListの最短文字列が5なのでn + n-5 + n-10 ... = n^2/2 = O(n^2)
  where
    wordList = ["dreamer", "dream", "eraser", "erase"]

main :: IO ()
main =
  interact $ \inputs ->
    let s = init inputs -- initで改行を外す
     in if solve s then "YES\n" else "NO\n"