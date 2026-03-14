import Control.Monad (guard)

main :: IO ()
main = do
  print $
    [ i * 2
      | i <- [0 .. 10],
        i `mod` 2 == 0
    ]
  print $ do
    i <- [0 .. 10]
    guard (i `mod` 2 == 0)
    return (i * 2)
