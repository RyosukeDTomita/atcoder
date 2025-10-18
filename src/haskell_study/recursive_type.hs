-- 再帰型
-- 自然数
data Nat = Zero | Succ Nat
  deriving (Show, Eq)

-- Zero or ある自然数の後者(successor)
-- Zero
-- Succ Zero = 1
-- Succ (Succ Zero) = 2
-- ...

-- 足し算
add :: Nat -> Nat -> Nat
add Zero n = n
add (Succ m) n = Succ (add m n)

main :: IO ()
main = do
  let zero = Zero
  let one = (Succ Zero)
  print zero
  print one
  print (add one one)