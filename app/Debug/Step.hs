{-# LANGUAGE DeriveGeneric #-}

module Debug.Step where

import Data.Aeson
import GHC.Generics
import Data.Map (Map)
import Data.Text (Text)

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
