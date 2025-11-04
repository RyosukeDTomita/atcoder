import Control.Monad (replicateM)
import Data.List (intercalate)

-- b棟f階r番目の部屋にv人が入居したことを更新する
update :: [[[Int]]] -> [Int] -> [[[Int]]]
update bld [b, f, r, v] =
  take (b - 1) bld -- b棟より前の棟を退避
    ++ [ take (f - 1) (bld !! (b - 1)) -- b棟のf階より前の棟を退避
           ++ [ take (r - 1) ((bld !! (b - 1)) !! (f - 1)) -- b棟のf階r番目の部屋以前のデータを退避
                  ++ [((bld !! (b - 1)) !! (f - 1) !! (r - 1)) + v] -- b棟のf階r番目の部屋にv人入居者を追加
                  ++ drop r ((bld !! (b - 1)) !! (f - 1)) -- b棟f階r番目以降の部屋のデータを連結
              ]
           ++ drop f (bld !! (b - 1)) -- b棟のf階より後の棟のデータを連結
       ]
    ++ drop b bld -- b棟よりも後の棟の情報を連結

-- 出力整形
printBuilding :: [[[Int]]] -> IO ()
printBuilding [] = return ()
-- 最後の1棟の処理
printBuilding [x] = mapM_ (putStrLn . concatMap ((' ' :) . show)) x -- NOTE: (' ' :)はスペースを連結することでスペースを追加する関数である。
-- ghci> concatMap ((' ' :) . show) [1,2,3]
-- " 1 2 3"

-- ###最後の1棟以外は###の区切りが必要
printBuilding (x : xs) = do
  mapM_ (putStrLn . concatMap ((' ' :) . show)) x
  putStrLn (replicate 20 '#')
  printBuilding xs

main :: IO ()
main = do
  n <- readLn
  infoN <- replicateM n $ map read . words <$> getLine :: IO [[Int]]
  -- print infoN

  -- 公舎4棟分の1フロア10部屋、3階建
  let initial = replicate 4 (replicate 3 (replicate 10 0))
  -- print initial
  let result = foldl update initial infoN
  printBuilding result
