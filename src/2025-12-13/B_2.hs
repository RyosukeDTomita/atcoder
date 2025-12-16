import Control.Arrow ((>>>))
import Data.Set qualified as Set

-- 各kに対して(r,c)が一意に決まることを利用する
solve :: Int -> [[Int]]
solve n =
  let start = (0, (n - 1) `div` 2)
      positions = scanl next (start, Set.singleton start) [2 .. n * n] -- NOTE: Set.singletonは要素を1つだけ持つSetを作る。
      -- 次の状態を作る関数
      next ((r, c), used) k =
        let p1 = ((r - 1) `mod` n, (c + 1) `mod` n) -- 対象のr,cが空白の場合の書き込み先
            p2 = ((r + 1) `mod` n, c) -- 第二候補
            p = if Set.member p1 used then p2 else p1
         in (p, Set.insert p used) --

      -- 全マスに対してvalを呼び、二次元配列を作る
      table =
        [ [ val i j
            | j <- [0 .. n - 1]
          ]
          | i <- [0 .. n - 1]
        ]
      -- kが置かれた座標(r,c)を見ていき、それがi jと一致した最初のkを返すことで(i,j)に置かれたkを求める。
      val :: Int -> Int -> Int
      val i j =
        head
          [ k
            | (k, ((r, c), _)) <- zip [1 ..] positions,
              r == i,
              c == j
          ]
   in table

main :: IO ()
main =
  interact $
    (read :: String -> Int) >>> solve >>> map (unwords . map show) >>> unlines