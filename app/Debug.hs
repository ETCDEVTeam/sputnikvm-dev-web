{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}

module Debug where

import Data.Aeson
import GHC.Generics
import Data.Text (Text)
import Data.Text.Lazy (fromStrict)
import Data.Text.Lazy.Encoding (encodeUtf8)
import Debug.Trace (DebugTrace)

data JSONRPCResponse a = JSONRPC Int a

instance FromJSON a => FromJSON (JSONRPCResponse a) where
  parseJSON (Object v) =
    JSONRPC <$> (v .: "id") <*> (v .: "result")
  parseJSON _ = fail "Expected an object"

decodeDebugTrace :: Text -> Maybe (JSONRPCResponse DebugTrace)
decodeDebugTrace = decode . encodeUtf8 . fromStrict

eitherDecodeDebugTrace :: Text -> Either String (JSONRPCResponse DebugTrace)
eitherDecodeDebugTrace = eitherDecode . encodeUtf8 . fromStrict

rpcResponseData :: JSONRPCResponse a -> a
rpcResponseData (JSONRPC _ d) = d
