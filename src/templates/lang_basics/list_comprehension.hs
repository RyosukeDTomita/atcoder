-- filterを使った素数リストを作成する例(エラトステネスのふるい)
primes :: [Integer]
primes = f [2 ..]
  where
    f (p : ns) = p : f (filter ((/= 0) . (`mod` p)) ns)

-- >>=を使った書き方
primes' :: [Integer]
primes' = f [2 ..]
  where
    f (p : ns) = p : f (ns >>= \n -> if n `mod` p /= 0 then [n] else [])

-- do記法
primes'' :: [Integer]
primes'' = f [2 ..]
  where
    f (p : ns) =
      p
        : f
          ( do
              n <- ns
              if n `mod` p /= 0 then [n] else []
          )

-- リスト内包表記
primes''' :: [Integer]
primes''' = f [2 ..]
  where
    f (p : ns) = p : f [n | n <- ns, n `mod` p /= 0]

main :: IO ()
main = do
  print $ take 10 primes
  print $ take 10 primes'
  print $ take 10 primes''
  print $ take 10 primes'''