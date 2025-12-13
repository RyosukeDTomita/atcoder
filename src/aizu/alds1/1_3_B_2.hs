-- 高速化バージョン
import Data.Sequence qualified as Seq

-- import qualified Data.Sequence as Seq -- AOJだとこっちをつかわないといけない。

parseProcess :: [String] -> (String, Int)
parseProcess (name : time) = (name, (read :: String -> Int) $ head time) -- headで[time]をtimeにしている

toStringProcess :: (String, Int) -> String
toStringProcess p = fst p ++ " " ++ show (snd p)

solve :: Int -> [(String, Int)] -> [String]
solve q process = go 0 (Seq.fromList process) []
  where
    go _ ps output
      | Seq.null ps = map toStringProcess $ reverse output -- NOTE: outputを先頭追加したのでreverseが必要
    go elapsedTime (p Seq.:<| ps) output
      | q >= snd p -- クオンタムでプロセスが完了する場合
        =
          let elapsedTime' = elapsedTime + snd p
           in go elapsedTime' ps ((fst p, elapsedTime') : output) -- NOTE: outputの末尾追加にするとO(n)なので先頭に追加して終了時にreverseすることでO(1)にする
      | otherwise =
          let elapsedTime' = elapsedTime + q
              p' = (fst p, snd p - q)
           in go elapsedTime' (ps Seq.|> p') output -- NOTE: sequenceで末尾への追加をO(1)に

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      [_, q] = map read . words $ head ls :: [Int]
      process = map (parseProcess . words) $ tail ls
   in unlines $ solve q process