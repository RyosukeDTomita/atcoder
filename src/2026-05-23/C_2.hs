{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}
{-# OPTIONS_GHC -Wunused-imports #-}

-- {-# OPTIONS_GHC -DATCODER #-}
import Data.ByteString.Char8 qualified as BS
import Data.IntMap.Strict qualified as IntMap
import Debug.Trace (traceShowId)

#ifdef ATCODER
debug :: Bool ; debug = False
#else
debug :: Bool ; debug = True
#endif

dbgId :: (Show a) => a -> a
dbgId x
  | debug = traceShowId x
  | otherwise = x

readInt :: BS.ByteString -> Int
readInt bs =
  case BS.readInt bs of
    Just (x, _) -> x
    Nothing -> error "input is not integer"

-- add : マスxに積んだ累計回数
-- countGE : countGE[k] = add[i] >= k なマス数(increment で維持する suffix count)
--   1 x でマス x の累計が old → old+1 に増えたとき、各しきい値 kへの所属がどう変わるかを考えます。
-- k <= old のしきい値: 増える前から add[x]=old >= k で既に数えられていた → 変化なし
-- k = old+1 のしきい値: 増える前は old >= old+1 偽、増えた後は old+1 >= old+1 真 →ここだけ新たに +1
-- k > old+1: 依然として満たさない → 変化なし
-- m : minAdd = 全消去回数 = max{ k | countGE[k] == n }
solve :: Int -> [[Int]] -> [Int]
solve n qs = go IntMap.empty IntMap.empty 0 qs
  where
    go :: IntMap.IntMap Int -> IntMap.IntMap Int -> Int -> [[Int]] -> [Int]
    go _ _ _ [] = []
    go add countGE !m (query : rest) = case query of
      [1, x] ->
        let old = IntMap.findWithDefault 0 x add
            add' = IntMap.insert x (old + 1) add
            countGE' = IntMap.insertWith (+) (old + 1) 1 countGE
            -- 全マスが m+1 以上になったら全消去 = minAdd++
            m' = if IntMap.findWithDefault 0 (m + 1) countGE' == n then m + 1 else m
         in go add' countGE' m' rest
      [2, y] -> IntMap.findWithDefault 0 (m + y) countGE : go add countGE m rest
      _ -> error "invalid query"

main :: IO ()
main =
  BS.interact $ \inputs ->
    let ls = BS.lines inputs
        [n, _] = map readInt . BS.words $ head ls
        qs = map (map readInt . BS.words) $ drop 1 ls :: [[Int]]
     in BS.unlines $ map (BS.pack . show) (solve n qs)
