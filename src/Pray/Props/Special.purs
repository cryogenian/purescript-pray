module Pray.Props.Special where

import Pray.Props

key :: forall a. (Attribute a) => a -> Props
key = mkProps "key"

ref :: String -> Props
ref = mkProps "ref"

-- dangerouslySetInnerHtml will not be implemented
