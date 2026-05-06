main :: IO ()
main = do
  let oneInt = 1 :: Int
  print oneInt
  let oneIntMaybe = pure oneInt :: Maybe Int -- これは値が変わっていないのでOK
  print oneIntMaybe -- Just 1

  -- let oneFloatMeybe = pure oneInt :: Meybe Float -- oneIntのが変わるのでNG。型変換のようなことはできない。
  let oneFloatMaybe = pure 1 :: Maybe Float -- 1がFloatとして型推論されるのでOK
  print oneFloatMaybe -- Just 1.0
