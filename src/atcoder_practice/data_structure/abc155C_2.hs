-- https://atcoder.jp/contests/abc155/tasks/abc155_c
{-# OPTIONS_GHC -Wno-x-partial #-}
{-# OPTIONS_GHC -Wunused-imports #-}
import Data.ByteString.Char8 qualified as BS
import Data.Map.Strict qualified as Map

solve :: [BS.ByteString] -> [BS.ByteString]
solve ss = (map fst . filter (\(_, n) -> n == maxFreq)) kvs -- v1ではmap fstを後からすると損な気がしたが、遅延評価なので関係なかった。
  where
    freq = Map.fromListWith (+) [(s, 1 :: Int) | s <- ss] -- Strict版を使うと1+1+...のサンクがたまらない
    kvs = Map.toList freq -- キー昇順ソート済みなので辞書順出力になる
    maxFreq = maximum $ map snd kvs

main :: IO ()
main =
  BS.interact $ \inputs ->
    let ls = BS.lines inputs
        ss = tail ls
     in BS.unlines $ solve ss
