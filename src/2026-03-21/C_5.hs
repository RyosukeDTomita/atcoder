-- 別解: https://atcoder.jp/contests/abc450/submissions/74288239 をもとに作成
{-# LANGUAGE BangPatterns #-}
{-# OPTIONS_GHC -Wunused-imports #-}

import Control.Monad (forM_, when)
import Data.ByteString.Char8 qualified as BS
import Data.Vector.Unboxed qualified as U
import Data.Vector.Unboxed.Mutable qualified as UM

readInt :: BS.ByteString -> Int
readInt bs = case BS.readInt bs of
  Just (x, _) -> x
  Nothing -> error "not int"

-- DSU: 経路圧縮つきfind
find :: UM.IOVector Int -> Int -> IO Int
find parent i = do
  p <- UM.read parent i
  if p == i
    then return i
    else do
      root <- find parent p
      UM.write parent i root -- 経路圧縮
      return root

-- DSU: サイズ優先マージ + atEdgeフラグ伝播
union_ :: UM.IOVector Int -> UM.IOVector Int -> UM.IOVector Bool -> Int -> Int -> IO ()
union_ parent sz atEdge x y = do
  rx <- find parent x
  ry <- find parent y
  when (rx /= ry) $ do
    sx <- UM.read sz rx
    sy <- UM.read sz ry
    ex <- UM.read atEdge rx
    ey <- UM.read atEdge ry
    let !edge = ex || ey
    if sx >= sy
      then do
        UM.write parent ry rx
        UM.write sz rx (sx + sy)
        UM.write atEdge rx edge
      else do
        UM.write parent rx ry
        UM.write sz ry (sx + sy)
        UM.write atEdge ry edge

main :: IO ()
main = do
  input <- BS.getContents
  let ls = BS.lines input
      [h, w] = map readInt . BS.words $ head ls
      -- グリッドを1次元にフラット化
      gridFlat = U.concat $ map (U.fromList . BS.unpack) (drop 1 ls)
      n = h * w
      isWhite !i = gridFlat U.! i == '.'

  -- DSU初期化
  parent <- UM.generate n id
  sz <- UM.replicate n (1 :: Int)
  -- 白マスかつ最外周ならTrue
  atEdge <- UM.generate n $ \i ->
    let (!y, !x) = i `divMod` w
     in isWhite i && (y == 0 || y == h - 1 || x == 0 || x == w - 1)

  -- 隣接する白マスをマージ（右と下だけ見ればよい）
  forM_ [0 .. h - 1] $ \y ->
    forM_ [0 .. w - 1] $ \x ->
      when (isWhite (y * w + x)) $
        forM_ [(y + 1, x), (y, x + 1)] $ \(!y', !x') ->
          when (y' < h && x' < w && isWhite (y' * w + x')) $
            union_ parent sz atEdge (y * w + x) (y' * w + x')

  -- 白マスの連結成分のルートのうち、最外周に触れていないものを数える
  count <-
    fmap sum $
      mapM
        ( \i ->
            if not (isWhite i)
              then return 0
              else do
                r <- find parent i
                if r /= i
                  then return 0
                  else do
                    e <- UM.read atEdge i
                    return $ if e then 0 else 1
        )
        [0 .. n - 1]

  print count
