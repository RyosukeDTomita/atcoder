{-# LANGUAGE ImportQualifiedPost #-}

import Control.Arrow ((>>>))
import Data.Char (toLower)
import Data.Map.Strict qualified as Map

-- 汎用的な頻度カウント関数（Ordならどんな型でもOK）
frequency :: (Ord a) => [a] -> Map.Map a Int
frequency a = foldl (\m c -> Map.insertWith (+) c 1 m) Map.empty a

-- 出力時にカウントが0の値も必要なため、内包表記を使っている。
format :: Map.Map Char Int -> String
format freqMap =
  unlines
    [ c : " : " ++ show (Map.findWithDefault 0 c freqMap)
      | c <- ['a' .. 'z']
    ]

solve :: String -> String
solve inputs =
  -- 要件に合わせて大文字小文字を無視するために事前に小文字に変換し、アルファベット以外の文字を排除している。
  let convertInputs = filter (\c -> c `elem` ['a' .. 'z']) $ map toLower inputs
   in format $ frequency convertInputs

main :: IO ()
main =
  interact solve
