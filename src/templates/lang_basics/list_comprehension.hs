-- filterを使った素数リストを作成する例(エラトステネスのふるい)
primes :: [Integer]
primes = f [2 ..]
  where
    f (p : ns) = p : f (filter ((/= 0) . (`mod` p)) ns)

main :: IO ()
main = do
  print $ take 10 primes