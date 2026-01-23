-- n = 2にするとバグる
import Control.Arrow ((>>>))
import Data.List (sortBy)
import Data.Ord (comparing)

type Point = (Double, Double)

solve :: Int -> [Point]
-- solve n = [((fromIntegral n :: Double), (fromIntegral n :: Double))]
solve n =
  let initPoint = [(0.0, 0.0), (100.0, 0.0)]
      result = iterate koch initPoint !! n
   in sortBy (comparing fst) result

koch :: [Point] -> [Point]
koch points = go [] points
  where
    -- newPoints: 操作実行後のn
    -- 第2引数
    go newPoints [] = newPoints
    go newPoints [p] = p : newPoints
    go newPoints (p1 : p2 : rest) =
      let diff = (fst p2 - fst p1, snd p2 - snd p1)
          s = (fst p1 + fst diff / 3, snd p1 + snd diff / 3)
          t = (fst p2 - fst diff / 3, snd p2 - snd diff / 3)
          u = rotateAround (pi / 3) s t
       in go (p1 : s : u : t : p2 : newPoints) rest

-- 任意の点(Cx,cy)を中心にした回転
rotateAround :: Double -> Point -> Point -> Point
rotateAround theta (cx, cy) (x, y) =
  let (x', y') = rotate theta (x - cx, y - cy)
   in (x' + cx, y' + cy)

rotate :: Double -> Point -> Point
rotate theta (x, y) =
  ( x * cos theta - y * sin theta,
    x * sin theta + y * cos theta
  )

-- newPoints: 今回の操作実行後
main :: IO ()
main =
  interact $
    (read :: String -> Int) >>> solve >>> map (\(x, y) -> show x ++ " " ++ show y) >>> unlines