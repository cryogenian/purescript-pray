module Pray.Props.Handler where

import Control.Monad.Eff
import Pray.Props 
import Pray.Event

--------------------------------------------------------------------------------
--                               Common
--------------------------------------------------------------------------------
type EEF e = Eff (synthetic :: SyntheticEventEff|e) Unit

foreign import toHandler """
function toHandler(dict) {
  return function(func) {
    return function() {
      return func(arguments[0])();
    };
  };
}
""" :: forall e ev . (SyntheticEvent ev) => (ev -> EEF e) -> EEF e

mkHandler :: forall e ev. (SyntheticEvent ev) => 
             String -> (ev -> EEF e) -> Props

mkHandler name func = mkProps name (toHandler func)

--------------------------------------------------------------------------------
--                               Clipboard
--------------------------------------------------------------------------------

onCopy :: forall e. (ClipboardEvent -> EEF e) -> Props
onCopy = mkHandler "onClick"

onCut :: forall e. (ClipboardEvent -> EEF e) -> Props
onCut = mkHandler "onCut"

onPaste :: forall e. (ClipboardEvent -> EEF e) -> Props
onPaste = mkHandler "onPaste"

--------------------------------------------------------------------------------
--                               Keyboard
--------------------------------------------------------------------------------

onKeyDown :: forall e. (KeyboardEvent -> EEF e) -> Props
onKeyDown = mkHandler "onKeyDown"

onKeyUp :: forall e. (KeyboardEvent -> EEF e) -> Props
onKeyUp = mkHandler "onKeyUp"

onKeyPress :: forall e. (KeyboardEvent -> EEF e) -> Props
onKeyPress = mkHandler "onKeyPress"

--------------------------------------------------------------------------------
--                               Focus
--------------------------------------------------------------------------------

onFocus :: forall e. (FocusEvent -> EEF e) -> Props
onFocus = mkHandler "onFocus"

onBlur :: forall e. (FocusEvent -> EEF e) -> Props
onBlur = mkHandler "onBlur"

--------------------------------------------------------------------------------
--                               Form
--------------------------------------------------------------------------------

onChange :: forall e. (FormEvent -> EEF e) -> Props
onChange = mkHandler "onChange"

onInput :: forall e. (FormEvent -> EEF e) -> Props
onInput = mkHandler "onInput"

onSubmit :: forall e. (FormEvent -> EEF e) -> Props
onSubmit = mkHandler "onSubmit"

--------------------------------------------------------------------------------
--                               Mouse
--------------------------------------------------------------------------------

-- Mouse Handler Setter :)
type MHS e = (MouseEvent -> EEF e) -> Props


onClick :: forall e. MHS e
onClick = mkHandler "onClick"

onDoubleClick :: forall e. MHS e
onDoubleClick = mkHandler "onDoubleClick"

onDrag :: forall e. MHS e
onDrag = mkHandler "onDrag"

onDragEnd :: forall e. MHS e
onDragEnd = mkHandler "onDragEnd"

onDragEnter :: forall e. MHS e
onDragEnter = mkHandler "onDragEnter"

onDragExit :: forall e. MHS e
onDragExit = mkHandler "onDragExit"

onDragLeave :: forall e. MHS e
onDragLeave = mkHandler "onDragLeave"

onDragOver :: forall e. MHS e
onDragOver = mkHandler "onDragOver"

onDragStart :: forall e. MHS e
onDragStart = mkHandler "onDragStart"

onDrop :: forall e. MHS e
onDrop = mkHandler "onDrop"

onMouseDown :: forall e. MHS e
onMouseDown = mkHandler "onMouseDown"

onMouseEnter :: forall e. MHS e
onMouseEnter = mkHandler "onMouseEnter"

onMouseLeave :: forall e. MHS e
onMouseLeave = mkHandler "onMouseLeave"

onMouseMove :: forall e. MHS e
onMouseMove = mkHandler "onMouseMove"

onMouseOut :: forall e. MHS e
onMouseOut = mkHandler "onMouseOut"

onMouseOver :: forall e. MHS e
onMouseOver = mkHandler "onMouseOver"

onMouseUp :: forall e. MHS e
onMouseUp = mkHandler "onMouseUp"

--------------------------------------------------------------------------------
--                               Touch
--------------------------------------------------------------------------------

-- Touch Handler Setter 
type THS e = (TouchEvent -> EEF e) -> Props

onTouchCancel :: forall e. THS e
onTouchCancel = mkHandler "onTouchCancel"

onTouchEnd :: forall e. THS e
onTouchEnd = mkHandler "onTouchEnd"

onTouchMove :: forall e. THS e
onTouchMove = mkHandler "onTouchMove"

onTouchStart :: forall e. THS e
onTouchStart = mkHandler "onTouchStart"

--------------------------------------------------------------------------------
--                               UI
--------------------------------------------------------------------------------

onScroll :: forall e. (UIEvent -> EEF e) -> Props
onScroll = mkHandler "onScroll"

--------------------------------------------------------------------------------
--                               Wheel
--------------------------------------------------------------------------------

onWheel :: forall e. (WheelEvent -> EEF e) -> Props
onWheel = mkHandler "onWheel"
