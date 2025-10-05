import Data.List (elemIndex)
import Data.Maybe (fromMaybe)

main :: IO ()
main = do
  -- 配列を事前定義
  let osVersions = ["Ocelot", "Serval", "Lynx"]

  [x, y] <- words <$> getLine

  -- 配列のどこにxとyが入っているか探す
  let idx = fromMaybe (-1) (elemIndex x osVersions)
  let idy = fromMaybe (-1) (elemIndex y osVersions)

  -- xがyよりも右にある場合にYesを、そうでないならNoを出力する
  let result = if idx >= idy then "Yes" else "No"
  putStrLn result
