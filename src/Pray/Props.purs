module Pray.Props where

import Control.Monad.Eff
import Data.Monoid
import Data.Function


class Attribute a
instance stringAttribute :: Attribute String
instance numberAttribute :: Attribute Number
instance fn1Attribute :: Attribute (Fn1 a b)
instance fn2Attribute :: Attribute (Fn2 a b c)
instance fn3Attribute :: Attribute (Fn3 a b c d)
instance fn4Attribute :: Attribute (Fn4 a b c d e)
instance functionAttribute :: Attribute (a -> b)
instance effAttribute :: Attribute (Eff e a)

foreign import data Props :: * 

foreign import mkProps """
function mkProps(dict) {
  return function(attrName) {
    return function(attrValue) {
      var result = {};
      result[attrName] = attrValue;
      return result;
    }
  }
}
""" :: forall a. (Attribute a) => String -> a -> Props 

foreign import propsAppend """
function propsAppend(propOne) {
  return function(propTwo) {
    var result = {};
    var keysOne = Object.getOwnPropertyNames(propOne);
    var keysTwo = Object.getOwnPropertyNames(propTwo);
    for (var i = 0; i < keysOne.length; i++) {
      result[keysOne[i]] = propOne[keysOne[i]];
    }
    for (var i = 0; i < keysTwo.length; i++) {
      result[keysTwo[i]] = propTwo[keysTwo[i]];
    }
    return result;
  }
}
""" :: Props -> Props -> Props

foreign import atProps """
function atProps(name) {
  return function(prop) {
    return prop[name];
  }
}
""" :: forall a . String -> Props -> a

infix 13 ^:
(^:) :: forall a. Props -> String -> a
(^:) = flip atProps

foreign import propsEmpty """
var propsEmpty = {};
""" :: Props


instance semigroupProp :: Semigroup Props where
  (<>) = propsAppend

instance monoidProp :: Monoid Props where
  mempty = propsEmpty


infix 20 <<-
(<<-) :: forall a. (Attribute a) => String -> a -> Props
(<<-) name val = mkProps name val

infix 20 :=
(:=) = (<<-)

noprop :: Props
noprop = mempty
