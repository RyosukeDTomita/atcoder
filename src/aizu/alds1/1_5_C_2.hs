-- sを中心にした60度回転からベクトルを60度回転に変更
import Control.Arrow ((>>>))
import Text.Printf (printf)

type Point = (Double, Double)

solve :: Int -> [Point]
solve n =
  let initPoint = [(0.0, 0.0), (100.0, 0.0)]
   in iterate koch initPoint !! n -- n回実行した結果のみを出力

koch :: [Point] -> [Point]
koch [] = []
koch [p] = [p]
koch (p1 : p2 : rest) =
  let (dx, dy) = (fst p2 - fst p1, snd p2 - snd p1)
      s = (fst p1 + dx / 3, snd p1 + dy / 3)
      t = (fst p1 + 2 * dx / 3, snd p1 + 2 * dy / 3)
      -- sからtへのベクトルを60度回転してsに加える
      (vx, vy) = (dx / 3, dy / 3)
      -- 60度回転: (x', y') = (x*cos60 - y*sin60, x*sin60 + y*cos60)
      u = (fst s + vx * 0.5 - vy * (sqrt 3 / 2), snd s + vx * (sqrt 3 / 2) + vy * 0.5)
   in p1 : s : u : t : koch (p2 : rest)

main :: IO ()
main =
  interact $
    -- (read :: String -> Int) >>> solve >>> map (\(x, y) -> printf "%.8f %.8f" x y) >>> unlines
    (read :: String -> Int) >>> solve >>> map (uncurry (printf "%.8f %.8f")) >>> unlines
