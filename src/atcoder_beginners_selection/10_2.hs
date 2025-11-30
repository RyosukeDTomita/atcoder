import Data.List (isPrefixOf)

-- NOTE: wordListは大きい順にしておく必要がある。eraserがある時にeraseでマッチすると壊れるから。go (reverse s)をしている関係上各単語の語順を逆にしている。
wordList :: [String]
wordList = map reverse ["dreamer", "dream", "eraser", "erase"]

-- 後ろからwordListにマッチするものがないか探す(一部高速化)
-- dreameraserの場合、前方でマッチするとdreamerがdreamより先に試行されるため、dreamerがマッチするとaserが残ってしまう。
-- 逆にdreamを先に試行させるとdreamerの場合erが残ってしまう。
-- このことから、後方からマッチするものがないものを探すかつ、長い文字列から調査する形をとっている。
solve :: String -> Bool
solve s = go (reverse s)
  where
    go "" = True -- 再帰で全ての文字列を消せるならS=T
    go sReverse =
      case filter (`isPrefixOf` sReverse) wordList of -- NOTE: isSuffixOfを使うと毎回O(n)になるので最適化
        [] -> False -- 末尾がマッチしない場合
        (word : _) -> go (drop (length word) sReverse) -- 末尾からword分だけ除去して再帰(O(n))に最適化

main :: IO ()
main =
  interact $ \inputs ->
    let s = init inputs -- initで改行を外す
     in if solve s then "YES\n" else "NO\n"