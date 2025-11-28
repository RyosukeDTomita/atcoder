solve :: String -> [String] -> [String]
solve str commands =
  let (_, outputs) = foldl run (str, []) commands
   in outputs

-- NOTE: process、reverse、printを個別に定義することも考えたが、各コマンドで文字列の再生性が必要なため、solveにまとめたほうが良いと判断した。
run :: (String, [String]) -> String -> (String, [String])
run (nowStr, outputs) command =
  case words command of
    ("print" : aStr : bStr : _) ->
      let a = read aStr :: Int
          b = read bStr :: Int
          out = drop a . take (b + 1) $ nowStr
       in (nowStr, outputs ++ [out])
    ("reverse" : aStr : bStr : _) ->
      let a = read aStr :: Int
          b = read bStr :: Int
          (left, rest) = splitAt a nowStr
          (mid, right) = splitAt (b - a + 1) rest
       in (left ++ reverse mid ++ right, outputs)
    ("replace" : aStr : bStr : pattern : _) ->
      let a = read aStr :: Int
          b = read bStr :: Int
          (left, rest) = splitAt a nowStr
          (_, right) = splitAt (b - a + 1) rest
       in (left ++ pattern ++ right, outputs)

main :: IO ()
main = interact $ \inputs ->
  let ls = lines inputs
      str = head ls
      q = read $ ls !! 1 :: Int
      commands = drop 2 ls
   in unlines $ solve str commands