import Text.Printf (printf)

main :: IO ()
main = do
  -- 型が曖昧なため、型注釈が必要(printfがpolymorphicな関数であるため)
  printf "%d %.5f\n" (42 :: Int) (pi :: Double)