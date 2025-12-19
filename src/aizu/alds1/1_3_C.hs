-- 結局メモリオーバーを突破できず
import Data.Char (digitToInt)
import Data.Foldable (foldl', toList)
import Data.Sequence (Seq (..), ViewL (..), ViewR (..), viewl, viewr)
import Data.Sequence qualified as Seq

-- import qualified Data.Sequence as Seq -- AOJだとこっちをつかわないといけない。

-- 先頭削除
deleteHead :: Seq a -> Seq a
deleteHead s = case viewl s of
  _ :< rest -> rest
  EmptyL -> s

-- 末尾削除
deleteLast :: Seq a -> Seq a
deleteLast s = case viewr s of
  rest :> _ -> rest
  EmptyR -> s

-- 指定した要素を削除する
deleteValue :: (Eq a) => a -> Seq a -> Seq a
deleteValue x xs = case Seq.findIndexL (== x) xs of
  Nothing -> xs
  Just i -> Seq.deleteAt i xs

solve :: [[String]] -> [Int]
solve commands = toList $ foldl' runCommand Seq.Empty commands -- foldlだとメモリオーバーになった。

runCommand :: Seq Int -> [String] -> Seq Int
runCommand seqXs [commandName, x]
  | commandName == "insert" = (read :: String -> Int) x Seq.<| seqXs
  | commandName == "delete" = deleteValue ((read :: String -> Int) x) seqXs
runCommand seqXs [commandName]
  | commandName == "deleteFirst" = deleteHead seqXs
  | commandName == "deleteLast" = deleteLast seqXs

main :: IO ()
main = interact $ \input ->
  let ls = lines input
      n = (read :: String -> Int) $ head ls
      commands = map words $ tail ls
   in (unwords $ map show $ solve commands) ++ "\n"