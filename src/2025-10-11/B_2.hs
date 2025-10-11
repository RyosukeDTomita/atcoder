import Data.Char (digitToInt)

-- f 123 = 1 + 2 + 3 = 6
f :: Int -> Int
f 0 = 1
f i = sum $ map digitToInt (show i) -- showで文字列に変換して、map digitToIntで文字列をIntの配列にするの。その後、その合計を求める

-- a n = a0 + a1 + a2 ... an-1
-- LTEになったので既に計算した値をキャッシュしてみた。
aList :: [Int]
aList = map a [0 ..] -- [0..]は無限リスト
  where
    a 0 = 1
    a i = sum $ map (f . (aList !!)) [0 .. (i - 1)]

main :: IO ()
main = do
  n <- readLn :: IO Int
  print (aList !! n)
