import Data.List (sortOn)
import Data.Ord (Down (..))

-- サイズ関係なく単純に順序を逆にして戻す
reverseInt :: [Int] -> [Int]
reverseInt [] = []
reverseInt (a : as) = reverseInt as ++ [a]

main :: IO ()
main = do
  _ <- readLn :: IO Int
  as <- map read . words <$> getLine :: IO [Int]
  putStrLn $ unwords (map show (reverseInt as))