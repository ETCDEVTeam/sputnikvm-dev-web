{-# LANGUAGE DeriveGeneric #-}

module Debug where

import Data.Aeson
import GHC.Generics
import Data.Text (Text)

data JSONRPCResponse a = JSONRPC Int a

instance FromJSON JSONRPCReponse where
  parseJSON (Object v) =
    JSONRPC <$> (v .: "result") <*> (v .: "id")
  parseJSON _ = fail "Expected an object"

data DebugTrace =
  DebugTrace { gas         :: Text
             , returnValue :: Text
             , structLogs  :: [DebugStep]
             } deriving (Show, Generic)

instance FromJSON DebugTrace
instance ToJSON DebugTrace

data DebugStep =
  DebugStep { depth   :: Int
            , error   :: Text
            , gas     :: Text
            , gasCost :: Text
            , memory  :: [Text]
            , op      :: Int
            , pc      :: Int
            , stack   :: [Text]
            , storage :: Map Text Text
            } deriving (Show, Generic)

instance FromJSON DebugStep
instance ToJSON DebugStep
