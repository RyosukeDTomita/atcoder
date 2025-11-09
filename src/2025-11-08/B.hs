import Control.Monad (replicateM)
import Data.Map.Strict qualified as Map

-- パーツの取り付け状態を追跡 -- TODO
-- seenには現在の取り付け状態が記録されている。
-- accはクエリの流れによって取り付けか取り外しかの情報が格納されている。
buildStateList :: [Int] -> [Int] -> [(Bool, Int)]
buildStateList wList queryList = snd $ foldl step (Map.empty, []) queryList -- 最終的に accだけ返している。
  where
    step (seen, acc) partIdx =
      let weight = wList !! (partIdx - 1)
          isRemove = Map.member partIdx seen -- partIdxというキーが存在するかの結果を格納
          newSeen =
            if isRemove
              then Map.delete partIdx seen -- 取り外しが必要ならseenから削除
              else Map.insert partIdx True seen -- パーツ追加
       in (newSeen, acc ++ [(isRemove, weight)])

-- queryの適用
applyQuery :: Int -> (Bool, Int) -> Int
applyQuery currentWeight (isRemove, weight) =
  if isRemove
    then currentWeight - weight
    else currentWeight + weight

main :: IO ()
main = do
  x <- readLn :: IO Int -- はじめのロボットの重さ
  n <- readLn :: IO Int -- パーツの数
  wList <- map read . words <$> getLine :: IO [Int] -- 各パーツの重さ
  q <- readLn :: IO Int -- クエリの数
  queryList <- replicateM q readLn :: IO [Int] -- クエリ
  let stateList = buildStateList wList queryList
  let weights = scanl applyQuery x stateList -- TODO: scanlの使い方として復習
  mapM_ print (tail weights)
