import Data.List (isInfixOf)

main :: IO ()
main = do
  let s = "Haskell is great programming language"
  print $ "Haskell" `isInfixOf` s -- True
  print $ "Has" `isInfixOf` s -- True