-- 既存の型を使う
kToCNoType :: Double -> Double
kToCNoType k = k - 273.15

-- 既存の型に名前をつけるとわかりやすい
type K = Double -- Kelvin

type C = Double -- Celsius

kToCType :: K -> C
kToCType k = k - 273.15

-- 新しい型をつくる
-- NOTE: Showインスタンスがないとprintできないので追加
newtype K2 = K2 Double deriving (Show)

newtype C2 = C2 Double deriving (Show)

-- (K2 k)はパターンマッチで値を取り出しているというらしい。K2で包まれた値を受け取って、中のDouble型を取り出すという意味
kToCnewType :: K2 -> C2
kToCnewType (K2 k) = C2 (k - 273.15)

main :: IO ()
main = do
  print (kToCNoType 0.0)
  print (kToCType 0.0)
  print (kToCnewType (K2 0.0)) -- 使用時にコンストラクタで囲む必要があるため、間違ってC2型の値をいれることがない
