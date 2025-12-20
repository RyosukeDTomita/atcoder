-- 方針が良くなかったACできず。
import Data.List (sort, sortOn, transpose)
import Data.Ord (Down (..))

solve :: [[[Double]]] -> [Int]
solve caseS =
  let sortedCaseS = map sortE caseS
   in map (\c -> ride [] c) sortedCaseS

-- [e, [w, p]]の配列を作り、eでソートする。eは体重あたりに運べる重さ
sortE :: [[Double]] -> [(Double, [Double])]
sortE case' =
  let ws = head case'
      ps = case' !! 1
      eCase =
        [ (ps !! i / ws !! i, [ws !! i, ps !! i])
          | i <- [0 .. length ws - 1]
        ]
   in sortOn fst eCase

--  in sortOn (Down . fst) eCase

ride :: [(Double, [Double])] -> [(Double, [Double])] -> Int
-- rided: すでにそりに乗っている
ride [] rided = length rided
ride (ec : rest) rided
  | calSumW (map snd (ec : rided)) >= calSumP (map snd rest) = length rided -- 新しく乗せると動かない
  | otherwise = ride rest (ec : rided)

calSumW :: [[Double]] -> Double
calSumW xs = sum $ map head xs

calSumP :: [[Double]] -> Double
calSumP xs = sum $ map (!! 1) xs

parse :: [String] -> [[[Double]]]
parse [] = []
parse (nStr : inputs) =
  let n = read nStr :: Int
      (caseT, rest) = splitAt n inputs
      [ws, ps] = transpose $ map (map readDouble . words) caseT
   in [ws, ps] : parse rest

readDouble :: String -> Double
readDouble = read

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      t = read $ head ls :: Int
      caseS = parse $ drop 1 ls :: [[[Double]]]
   in show (solve caseS) ++ "\n"