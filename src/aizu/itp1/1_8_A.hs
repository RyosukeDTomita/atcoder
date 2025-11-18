import Control.Arrow ((>>>))
import Data.Char (isLower, isUpper, toLower, toUpper)

swapCase :: Char -> Char
swapCase c
  | isLower c = toUpper c
  | isUpper c = toLower c
  | otherwise = c

main :: IO ()
main =
  interact $ map swapCase
