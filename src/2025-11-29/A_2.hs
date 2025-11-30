-- byteStringを使ったりして改良してみたが入力サイズが小さいとByteStringを使うオーバーヘッドの方がでかかった。
import Control.Arrow ((>>>))
import Data.ByteString.Char8 qualified as BS
import Data.Maybe (fromJust)

solve :: [Int] -> Int
solve [w, b] = w * 1000 `div` b + 1

main :: IO ()
main =
  BS.interact $
    -- BS.packでByteStringに変換している。
    BS.words >>> map (fst . fromJust . BS.readInt) >>> solve >>> show >>> BS.pack >>> (<> BS.pack "\n")