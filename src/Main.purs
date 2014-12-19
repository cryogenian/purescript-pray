module Main where

import Prelude hiding (id)

import Control.Monad.Eff
import Data.Foldable
import Data.Array ((..), (!!), zipWith, length)
import Data.Tuple
import Data.Function
import Data.Maybe

import Pray.Props
import Pray.Props.Handler
import Pray.Props.Special
import Pray.Event (
  MouseEvent(..),
  KeyboardEvent(..),
  FormEvent(..),
  preventDefault,
  getValue
  )
import Pray.React
import Pray.Free
import Pray.React.Html hiding (main, body)
import Pray.Props.Html (
  className,
  href,
  id,
  role,
  typeProp,
  value
  )

foreign import onload """
function onload(handler) {
  return function() {
    window.onload = handler;
  };
}
""" :: forall e. Eff e Unit -> Eff e Unit


foreign import alert """
function alert(a) {
  return function() {
    window.alert(a);
  };
}
""" :: forall a e. a -> Eff e Unit


wrapper = defineClass $ do
  display "Wrapper"
  render $ \react ->
    unsafeRunUI do
      div ! className "wrapper" $$ do
        div ! className "container" $$ do
          div ! className "row" $$ do
            div
              ! className "col-xs-6 col-xs-offset-3"
              $$ do
                injectChildren react


todoChanged :: forall e. React -> FormEvent -> Eff e Unit
todoChanged react event = do
  let v :: String
      v = getValue event
  state <- getState react
  setState react state{value = v}
  return unit


todoSubmited :: forall e. React -> String -> FormEvent -> Eff e Unit
todoSubmited react value event = do
  preventDefault event
  modifyState react \state ->
    let i = length state.todos
        var = Tuple i value
    in state{todos = var:state.todos}
  return unit

enterPressed :: forall e. React -> KeyboardEvent -> Eff e Unit
enterPressed react event = return unit

inputFormCls = defineClass $ do
  state {value: ""}
  render $ \react -> do
    let parent :: React
        parent = (properties react) ^: "parent"
    state <- getState react
    unsafeRunUI $ do
      form
        ! role "form"
        ! id "login-form"
        ! onSubmit $ todoSubmited parent state.value
        $$ do
          input
            ! typeProp "text"
            ! ref "input"
            ! onChange $ todoChanged react
            ! onKeyDown $ enterPressed react
            $$ raw state.value


toggle this event = do
  modifyState this $ \state ->
    let edit :: Boolean
        edit = state.edit
    in state{edit = not edit}
  return unit



changeSuccess :: forall e. React -> FormEvent -> Eff e Unit
changeSuccess this event = do
  preventDefault event
  modifyState this $ \state ->
    state{edit = false}
  return unit

todoCls = defineClass $ do
  state {edit: false, value: ""}
  render $ \this -> do
    state <- getState this
    let touched :: Boolean
        touched = state.touched
        v :: String 
        v = if touched then state.value else (properties this) ^: "value"
        parent :: React
        parent = (properties this) ^: "parent"
        index :: Number
        index = (properties this) ^: "index"
    unsafeRunUI $ do
      form ! className "form-inline" ! role "form"
        ! onSubmit $ changeSuccess this
        $$ do
        div ! className "checkbox"
          $$ do
            input ! typeProp "checkbox"
              ! onChange $ toggle this
        div ! className "form-group"
          $$ do
            if state.edit then do 
              input
                ! typeProp "text"
                ! className "form-control"
                ! value v

              else do
              div $$ raw v
              

mkToDo = addNewEl todoCls

tstCls = defineClass $ do
  state {todos: []}
  render $ \this -> do
    state <- getState this
    unsafeRunUI $ do
      addNewEl wrapper ! key "wrapper" $$ do
          addNewEl inputFormCls
            ! key "form"
            ! "parent" := this
          let todos :: [Tuple Number String]
              todos = state.todos
          for_ todos $ \(Tuple i todo) -> do
            mkToDo ! key i ! value todo ! "parent" := this ! "index" := i


main = onload $ do
  renderToBody $ mkEl tstCls noprop []
