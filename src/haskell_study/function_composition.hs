-- 関数合成を試す
-- 桁数を求める関数
digits :: Int -> Int
digits = length . show

-- 処理イメージ
-- (length . show) 12345
-- 合成関数の定義より、引数を先にshowに適用して
-- length (show 12345)
-- length "12345"
-- 5

main :: IO ()
main = do
  print (digits 12345)