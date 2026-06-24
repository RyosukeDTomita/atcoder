import Data.Map qualified as Map
import Data.Set qualified as Set

main :: IO ()
main = do
  let xSet = Set.fromList [1, 2, 3]
  print xSet
  -- fromSet: Setの各要素をキーに, 関数で計算した値を持つMapを作る
  let xMap = Map.fromSet (\k -> ['a' ..] !! k) xSet -- [(1,'b'),(2,'c'),(3,'d')]
  print xMap

  let yMap = Map.fromList [("john", 20), ("sigma", 29)] -- [("john",20),("sigma",29)]
  print yMap
  let yMap' = Map.insert "taro" 19 yMap -- 仮に存在する場合には上書きする
  print yMap'
  let yMap'' = Map.insertWith (+) "taro" 1 yMap' -- 存在する倍には+1インクリメント
  let yMap''' = Map.insertWith (+) "ken" 1 yMap'' -- 存在しない場合にはデフォルト値1をいれる
  print yMap'''
  let (prevAge, yMap'''') = Map.insertLookupWithKey (\_ _ old -> old + 1) "ken" 1 yMap''' -- 存在しない場合にはデフォルト値1をいれる。存在するならインクリメントしつつ、値の取得も行う
  print prevAge -- Just 1
  print yMap''''
  let yMapD = Map.delete "john" yMap

  print yMap''
  print $ Map.lookup "john" yMap -- Just 20
  print $ yMap Map.!? "john" -- Just 20
  print $ yMap Map.! "john" -- 20
  print $ "john" `Map.member` yMap -- True
  -- Nothingの時デフォルト値を使う
  print $ Map.findWithDefault (-99) "hoge" yMap
