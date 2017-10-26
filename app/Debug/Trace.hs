{-# LANGUAGE DeriveGeneric #-}

module Debug.Trace where

import Data.Aeson
import GHC.Generics
import Data.Text (Text)
import Debug.Step (DebugStep)

data DebugTrace =
  DebugTrace { gas         :: Text
             , returnValue :: Text
             , structLogs  :: [DebugStep]
             } deriving (Show, Generic)

instance FromJSON DebugTrace
instance ToJSON DebugTrace
