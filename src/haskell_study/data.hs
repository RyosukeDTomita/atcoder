-- data型で完全に新しい型を作る
-- OK、Found、NotFoundはHTTPStatus型になる
data HTTPStatus
  = OK
  | Found
  | NotFound
  deriving (Show, Eq)

statusMessageToCode :: HTTPStatus -> Int
statusMessageToCode OK = 200
statusMessageToCode Found = 301
statusMessageToCode NotFound = 404

main :: IO ()
main = do
  print (statusMessageToCode OK)
  print (statusMessageToCode Found)
  print (statusMessageToCode NotFound)