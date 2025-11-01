newtype Identity a = Identity {runIdentity :: a}
  deriving (Show, Eq)

-- Functorインスタンス（Monadの前提条件）
instance Functor Identity where
  fmap :: (a -> b) -> Identity a -> Identity b
  fmap f (Identity x) = Identity (f x)

-- Applicativeインスタンス（Monadの前提条件）
instance Applicative Identity where
  pure :: a -> Identity a
  pure = Identity
  (<*>) :: Identity (a -> b) -> Identity a -> Identity b
  Identity f <*> Identity x = Identity (f x)

-- Monadインスタンス
instance Monad Identity where
  (>>=) :: Identity a -> (a -> Identity b) -> Identity b
  Identity x >>= f = f x

main :: IO ()
main = do
  -- 基本的な使用例
  let id1 = Identity 5
  putStrLn $ "id1 = " ++ show id1

  -- return の動作
  let id2 = return 10 :: Identity Int
  putStrLn $ "return 10 = " ++ show id2

  -- >>= の動作
  let result = id1 >>= (\x -> Identity (x * 2))
  putStrLn $ "Identity 5 >>= (\\x -> Identity (x * 2)) = " ++ show result

  -- runIdentity で値を取り出す
  putStrLn $ "runIdentity result = " ++ show (runIdentity result)