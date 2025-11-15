import Data.List (sort, sortOn)
import Data.Ord (Down (..))

main :: IO ()
main = interact $ \inputs ->
  let xs = map read . words $ inputs :: [Int]
   in concat (map show $ sortOn (Down) xs) ++ "\n"