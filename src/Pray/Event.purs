module Pray.Event where
import Control.Monad.Eff
import Data.Date

foreign import data SyntheticEventEff :: !

foreign import data ClipboardEvent :: *
foreign import data KeyboardEvent :: *
foreign import data FocusEvent :: *
foreign import data FormEvent :: *
foreign import data MouseEvent :: * 
foreign import data TouchEvent :: *
foreign import data UIEvent :: *
foreign import data WheelEvent :: *


class SyntheticEvent event

instance clipboardSyntheticEvent :: SyntheticEvent ClipboardEvent
instance keyboardSyntheticEvent :: SyntheticEvent KeyboardEvent
instance focusSyntheticEvent :: SyntheticEvent FocusEvent
instance formSyntheticEvent :: SyntheticEvent FormEvent
instance mouseSyntheticEvent :: SyntheticEvent MouseEvent
instance touchSyntheticEvent :: SyntheticEvent TouchEvent
instance uiSyntheticEvent :: SyntheticEvent UIEvent
instance wheelSyntheticEvent :: SyntheticEvent WheelEvent


class (SyntheticEvent event) <= InputEvent event

instance keyboardInputEvent :: InputEvent KeyboardEvent
instance mouseInputEvent :: InputEvent MouseEvent
instance touchInputEvent :: InputEvent TouchEvent

--------------------------------------------------------------------------------
--                               Common
--------------------------------------------------------------------------------

foreign import bubbles """
function bubbles(dict) {
  return function(ev) {
    return ev.bubbles;
  };
}
""" :: forall ev. (SyntheticEvent ev) => ev -> Boolean

foreign import cancelable """
function cancelable(dict) {
  return function(ev) {
    return ev.cancelable;
  };
}
""" :: forall ev. (SyntheticEvent ev) => ev -> Boolean

-- Do not know what kind of Dom Library will be used
foreign import currentTarget """
function currentTarget(dict) {
  return function(ev) {
    return ev.currentTarget;
  };
}
""" :: forall ev dom. (SyntheticEvent ev) => ev -> dom

foreign import defaultPrevented """
function defaultPrevented(dict) {
  return function(ev) {
    return ev.defaultPrevented;
  };
}
""" :: forall ev. (SyntheticEvent ev) => ev -> Boolean

foreign import eventPhase """
function eventPhase(dict) {
  return function(ev) {
    return ev.eventPhase;
  }
}
""" :: forall ev. (SyntheticEvent ev) => ev -> Number

foreign import isTrusted """
function isTrusted(dict) {
  return function(ev) {
    return ev.isTrusted;
  };
}
""" :: forall ev. (SyntheticEvent ev) => ev -> Boolean

-- Do not know what kind of DOM library will be used
foreign import nativeEvent """
function nativeEvent(dict) {
  return function(ev) {
    return ev.nativeEvent;
  };
}
""" :: forall native ev. (SyntheticEvent ev) => ev -> native

foreign import preventDefault """
function preventDefault(dict) {
  return function(ev) {
    return function() {
      return ev.preventDefault();
    };
  };
}
""" :: forall ev e. (SyntheticEvent ev) => ev -> Eff e Unit

foreign import stopPropagation """
function stopPropagation(dict) {
  return function(ev) {
    return function() {
      return ev.stopPropagation();
    };
  };
}
""" :: forall ev e. (SyntheticEvent ev) => ev -> Eff e Unit

-- Do not know DOM library

foreign import target """
function target(dict) {
  return function(ev) {
    return ev.target;
  }
}
""" :: forall ev dom. (SyntheticEvent ev) => ev -> dom


foreign import timeStamp """
function timeStamp(dict) {
  return function(ev) {
    return ev.timeStamp;
  };
}
""" :: forall ev. (SyntheticEvent ev) => ev -> JSDate

foreign import typeString """
function typeString(dict) {
  return function(ev) {
    return ev.type;
  }
}
""" :: forall ev. (SyntheticEvent ev) => ev -> String


--------------------------------------------------------------------------------
--                               Input
--------------------------------------------------------------------------------

foreign import altKey """
function altKey(dict) {
  return function(ev) {
    return ev.altKey;
  };
}
""" :: forall ev. (InputEvent ev) => ev -> Boolean

foreign import ctrlKey """
function ctrlKey(dict) {return function(ev) {return ev.ctrlKey;};}
""" :: forall ev. (InputEvent ev) => ev -> Boolean

foreign import metaKey """
function metaKey(dict) {return function(ev) {return ev.metaKey;};}
""" :: forall ev. (InputEvent ev) => ev -> Boolean

foreign import shiftKey """
function shiftKey(dict) {return function(ev) {return ev.shiftKey;};}
""" :: forall ev. (InputEvent ev) => ev -> Boolean


foreign import getModifierState """
function getModifierState(dict) {
  return function(ev) {
    return function(key) {
      return ev.getModifierState(key);
    };
  };
};
""" :: forall ev. (InputEvent ev) => ev -> String -> Boolean

--------------------------------------------------------------------------------
--                               Clipboard 
--------------------------------------------------------------------------------

foreign import clipboardData """
function clipboardData(ev) {
  return ev.clipboardData;
}
""" :: forall domTransfer. ClipboardEvent -> domTransfer

--------------------------------------------------------------------------------
--                              Keyboard
--------------------------------------------------------------------------------



foreign import charCode """
function charCode(ev) {return ev.charCode;}
""" :: KeyboardEvent -> Number

foreign import key """
function key(ev) {return ev.key;}
""" :: KeyboardEvent -> String

foreign import keyCode """
function keyCode(ev) {return ev.keyCode;}
""" :: KeyboardEvent -> Number

foreign import locale """
function locale(ev) {return ev.locale;}
""" :: KeyboardEvent -> String

foreign import location """
function location(ev) {return ev.location;}
""" :: KeyboardEvent -> Number

foreign import repeat """
function repeat(ev) {return ev.repeat;}
""" :: KeyboardEvent -> Boolean



foreign import which """
function which(ev) {return ev.which;}
""" :: KeyboardEvent -> Number

--------------------------------------------------------------------------------
--                              Focus
--------------------------------------------------------------------------------

-- Do not know what is DOMEVentTarget

foreign import relatedTarget """
function relatedTarget(ev) {return ev.relatedTarget;}
""" :: forall domEventTarget. FocusEvent -> domEventTarget

--------------------------------------------------------------------------------
--                               Form
--------------------------------------------------------------------------------

foreign import getValue """
function getValue(ev) {return ev.target.value;}
""" :: forall a. FormEvent -> a

--------------------------------------------------------------------------------
--                               Mouse
--------------------------------------------------------------------------------

foreign import button """
function button(ev) {return ev.button;}
""" :: MouseEvent -> Number

foreign import buttons """
function buttons(ev) {return ev.buttons;}
""" :: MouseEvent -> Number

foreign import clientX """
function clientX(ev) {return ev.clientX;}
""" :: MouseEvent -> Number

foreign import clientY """
function clientY(ev) {return ev.clientY;}
""" :: MouseEvent -> Number

foreign import pageX """
function pageX(ev) {return ev.pageX;}
""" :: MouseEvent -> Number

foreign import pageY """
function pageY(ev) {return ev.pageY;}
""" :: MouseEvent -> Number

foreign import screenX """
function screenX(ev) {return ev.screenX;}
""" :: MouseEvent -> Number

foreign import screenY """
function screenY(ev) {return ev.screenY;}
""" :: MouseEvent -> Number


--------------------------------------------------------------------------------
--                              Touch
--------------------------------------------------------------------------------

foreign import turnOnTouchEvents """
function turnOnTouchEvents() {
  var react = require('react');
  react.initializeTouchEvents(true);
}
""" :: forall e. Eff e Unit

foreign import turnOffTouchEvents """
function turnOffTouchEvents() {
  var react = require('react');
  react.initializaTouchEvents(false);
}
""" :: forall e. Eff e Unit

-- Another functions with unknown types of DOM
foreign import changedTouches """
function changedTouches(ev) {return ev.changedTouches;}
""" :: forall domTouchList. TouchEvent -> domTouchList

foreign import targetTouches """
function targetTouches(ev) {return ev.targetTouches;}
""" :: forall domTouchList. TouchEvent -> domTouchList

foreign import touches """
function touches(ev) {return ev.touches;}
""" :: forall domTouchList. TouchEvent -> domTouchList

--------------------------------------------------------------------------------
--                              UI
--------------------------------------------------------------------------------

foreign import detail """
function detail(ev) {return ev.detail;}
""" :: UIEvent -> Number

foreign import view """
function view(ev) {return ev.view;}
""" :: forall domAbstractView. UIEvent -> domAbstractView

--------------------------------------------------------------------------------
--                               Wheel
--------------------------------------------------------------------------------

foreign import deltaMode """
function deltaMode(ev) {return ev.deltaMode;}
""" :: WheelEvent -> Number

foreign import deltaX """
function deltaX(ev) {return ev.deltaX;}
""" :: WheelEvent -> Number

foreign import deltaY """
function deltaY(ev) {return ev.deltaY;}
""" :: WheelEvent -> Number

foreign import deltaZ """
function deltaZ(ev) {return ev.deltaZ;}
""" :: WheelEvent -> Number


