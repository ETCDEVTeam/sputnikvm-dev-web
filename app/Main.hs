{-# LANGUAGE OverloadedStrings #-}

import Reflex
import Reflex.Dom
import qualified Data.Map as Map

main :: IO ()
main = mainWidgetWithHead headElement bodyElement

headElement :: MonadWidget t m => m ()
headElement = do
  el "title" (text "SputnikVM Development Environment")
  styleSheet "css/style.css"
  where
    styleSheet link = elAttr "link" (Map.fromList [
                                        ("rel", "stylesheet")
                                        , ("type", "text/css")
                                        , ("href", link)
                                        ]) $ return ()

bodyElement :: MonadWidget t m => m ()
bodyElement = el "h1" (text "Hello, world!")
