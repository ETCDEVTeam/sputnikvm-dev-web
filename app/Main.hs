{-# LANGUAGE OverloadedStrings, RecursiveDo #-}

module Main where

import Reflex
import Reflex.Dom
import Control.Monad
import Control.Monad.IO.Class
import qualified Data.Map as Map
import qualified Data.Text as T

import Debug
import Debug.Step (DebugStep)
import qualified Debug.Step as Step
import Debug.Trace (DebugTrace)
import qualified Debug.Trace as Trace

main :: IO ()
main = mainWidgetWithHead headElement bodyElement

title :: T.Text
title = "SputnikVM Development Environment"

headElement :: MonadWidget t m => m ()
headElement = do
  el "title" (text title)
  styleSheet "style.css"
  where
    styleSheet link = elAttr "link" (Map.fromList [
                                        ("rel", "stylesheet")
                                        , ("type", "text/css")
                                        , ("href", link)
                                        ]) $ return ()

bodyElement :: MonadWidget t m => m ()
bodyElement = do
  descriptionElement
  response <- actionElement
  el "p" $ dynText <=< holdDyn "" $ response

descriptionElement :: MonadWidget t m => m ()
descriptionElement = do
  el "h1" (text title)
  el "p" (text "Enter a valid transaction hash below to get its debug information.")

actionElement :: MonadWidget t m => m (Event t T.Text)
actionElement = do
  request <- do
    rec transactionHash <- textInput $
          def & setValue .~ fmap (\_ -> "") debugSend
        debugSend <- button "Debug"
    return $ ffilter (/="") $ tag (current (value transactionHash)) debugSend
  fmap (fmapMaybe _xhrResponse_responseText) $ performRequestAsync $ fmap requestFromHash request

requestFromHash :: T.Text -> XhrRequest T.Text
requestFromHash hash =
  XhrRequest "POST" "http://127.0.0.1:8545" $
    (XhrRequestConfig
     { _xhrRequestConfig_sendData = T.concat [ "{\"method\": \"debug_traceTransaction\","
                                             , "\"params\": [\"", hash, "\"],"
                                             , "\"jsonrpc\": \"2.0\","
                                             , "\"id\": 1}"
                                             ]
     , _xhrRequestConfig_headers = Map.singleton "Content-Type" "application/json"
     , _xhrRequestConfig_user = Nothing
     , _xhrRequestConfig_password = Nothing
     , _xhrRequestConfig_responseType = Nothing
     , _xhrRequestConfig_responseHeaders = def
     , _xhrRequestConfig_withCredentials = False
     })
