-- 末端 or 枝の値コンストラクタを持つTree型
data Tree a
  = Leaf {element :: a} -- 末端
  | Fork {element :: a, left :: Tree a, right :: Tree a} -- 枝
  -- この書き方をするとelem-- 自動生成される関数
  -- element :: Tree a -> a          -- elementフィールドを取得
  -- left    :: Tree a -> Tree a     -- leftフィールドを取得
  -- right   :: Tree a -> Tree a     -- rightフィールドを取得ent、left、right関数が自動生成される。
  deriving (Show, Eq)

-- 無限に広がる2分木
dtree :: Tree Integer
dtree = dtree' 0
  where
    dtree' depth = Fork {element = depth, left = dtree' (depth + 1), right = dtree' (depth + 1)}

main :: IO ()
main = do
  print $ Fork 1 (Leaf 2) (Leaf 3)
  -- print dtree -- 無限に二分木が表示される
  print $ right dtree
  print $ (element . right) dtree -- 遅延評価により、dtreeの定義通り、dtree' 0をwhereに適用した際の