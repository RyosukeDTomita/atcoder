{-# LANGUAGE CPP #-}
{-# LANGUAGE OverloadedStrings #-}

-- {-# OPTIONS_GHC -DATCODER #-}
import Data.ByteString (ByteString)
import Data.ByteString.Char8 qualified as BS
import Data.List (foldl', sort)
import Data.Sequence (Seq, ViewR (..))
import Data.Sequence qualified as Seq
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

-- n: カップの総数
-- k: 酒の入っているカップの個数
-- x: 高橋くんが飲む必要のある酒の量
-- as: コップの液体の量
-- n - k杯飲めば次は確実に酒入り
-- asを小さい順にsortしたas'のうち、n-k +1番目から順番に飲ませていき、xを超えたところで止めるのが最悪ケース
solve :: Int -> Int -> Int -> [Int] -> Int
solve n k x as =
  let as' = Seq.fromList $ sort as
      (asl, asr) = Seq.splitAt k as'
      i = fst $ check (0, 0) asl -- iが負の数の場合: 最悪ケースではどのカップを選んでも酒が足りない
   in if i < 0 then -1 else n - k + (fst $ go (0, 0) asr)
  where
    -- 酒の総量が最小の場合=aslにすべての酒が入っていた場合に酒は足りるかチェックする
    -- i: 飲んだ酒コップの数
    -- drank: 飲んだ量
    check (i, drank) seq
      | Seq.null seq = (-1, -1) -- 酒が足りないのでエラー値
      | x > drank' = check ((i + 1), drank') (Seq.drop 1 seq)
      | otherwise = ((i + 1), drank)
      where
        a = Seq.index seq 0
        drank' = drank + a

    go (i, drank) seq =
      case popLast seq of
        Nothing -> (-1, -1) -- 酒が足りないのでエラー値
        Just (rest, a)
          | x > drank' -> go ((i + 1), drank') rest
          | otherwise -> ((i + 1), drank)
          where
            drank' = drank + a

popLast :: Seq a -> Maybe (Seq a, a)
popLast s =
  case Seq.viewr s of
    EmptyR -> Nothing
    xs :> x -> Just (xs, x)

main :: IO ()
main =
  BS.interact $ \inputs ->
    let ls = BS.lines inputs
        [n, k, x] = map readInt . BS.words $ head ls
        as = map readInt . BS.words $ ls !! 1 :: [Int]
     in (BS.pack . show) (solve n k x as) <> BS.pack "\n"