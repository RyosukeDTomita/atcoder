{-# LANGUAGE CPP #-}

import Data.List (foldl')
import Debug.Trace (traceShowId)

-- {-# OPTIONS_GHC -DATCODER #-}
#ifdef ATCODER
debug :: Bool ; debug = False
#else
debug :: Bool ; debug = True
#endif

dbgId :: (Show a) => a -> a
dbgId x
  | debug = traceShowId x
  | otherwise = x

solve :: String -> [Int]
solve s =
  -- s = \\//の場合
  -- foldl' step ([], []) (zip [0 ..] "\\//")
  -- = foldl' step (step ([], []) (0,'\')) [(1,'\'),(2,'/'), (3,'/')]
  -- = foldl' step ([0], []) [(1,'\'),(2,'/'),(3,'/')]
  -- = foldl' step (step ([0], []) (1,'\')) [(2,'/'),(3,'/')]
  -- = foldl' step ([0,1], []) [(2,'/'),(3,'/')]
  -- = foldl' step (step ([1,0], []) (2,'/')) [(3,'/')]
  -- j = 1、i=2よりbaseArea = 2-1 = 1
  -- (nested, restPuddle) = span (\(k, _) -> k > 1) [] = ([],[])により
  -- = foldl' step ([0], [(1, 1)]) [(3,'/')]
  -- = foldl' step (step ([0], [(1, 1)]) (3,'/')]) []
  -- j = 0、i=3よりbaseArea = 3
  -- (nested, restPuddle) = span (\(k, _) -> k > 0) [(1,1)] = ([(1,1)],[])
  -- = foldl' step ([],(0,4)) []
  -- = ([],(0,4))
  let (_, puddles) = foldl' step ([], []) (zip [0 ..] s)
   in map snd puddles
  where
    -- 引数=stackSlope: '\' の位置スタック, stackPuddle: (開始位置, 面積)
    -- 戻り値=stackSlope, stackPuddle
    step :: ([Int], [(Int, Int)]) -> (Int, Char) -> ([Int], [(Int, Int)])
    step (stackSlope, stackPuddle) (i, c) =
      case dbgId $ c of
        '\\' ->
          (i : stackSlope, stackPuddle) -- NOTE: スタックとして積むため先頭ほど新しいデータ
        '/' ->
          case stackSlope of
            [] -> (stackSlope, stackPuddle) -- 対応する '\' が無い
            j : restSlope ->
              let baseArea = i - j -- 1番外側の\ /により作られる面積
              -- nestされた面積を足す。NOTE: スタックが先頭に新しいデータを格納する構造なので\\//のような水たまりの場合には内側の水たまりの面積が先に計算されるようにできている。
                  (nested, restPuddle) = span (\(k, _) -> k > j) stackPuddle -- k > jな水たまりは全部
                  totalArea = baseArea + sum (map snd nested)
               in (restSlope, (j, totalArea) : restPuddle)
        _ ->
          (stackSlope, stackPuddle)

main :: IO ()
main =
  interact $ \inputs ->
    let line = takeWhile (/= '\n') inputs
        areas = reverse (solve line) -- 左から順にする
        total = sum areas
     in unlines
          [ show total,
            unwords (show (length areas) : map show areas)
          ]
