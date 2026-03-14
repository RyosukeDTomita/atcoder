{-# LANGUAGE OverloadedStrings #-}

import Data.ByteString.Char8 qualified as BS

main :: IO ()
main = do
  let bs = "this is ByteString" :: BS.ByteString
  BS.putStrLn bs

  case BS.uncons bs of
    Nothing -> putStrLn "empty"
    Just (c, rest) -> do
      print c
      BS.putStrLn rest
