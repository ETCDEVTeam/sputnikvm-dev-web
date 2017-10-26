{-# LANGUAGE OverloadedStrings, DeriveGeneric #-}

module Debug where

import Data.Aeson
import GHC.Generics
import Data.Text (Text)

data JSONRPCResponse a = JSONRPC Int a

instance FromJSON a => FromJSON (JSONRPCResponse a) where
  parseJSON (Object v) =
    JSONRPC <$> (v .: "result") <*> (v .: "id")
  parseJSON _ = fail "Expected an object"
