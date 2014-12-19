module Pray.React where

import Control.Monad
import Control.Monad.Eff 
import Control.Monad.State
import Control.Monad.State.Class
import Control.Monad.State.Trans

import Data.Exists (mkExists, Exists(..))
import Data.Function
import Data.Array (reverse)
import Data.Maybe
import DOM

import Pray.Props

foreign import data React :: *
foreign import data ReactRenderEff :: !
foreign import data ReactClass :: *
foreign import data Refs :: * 


instance reactAttribute :: Attribute React



foreign import documentBody """
function documentBody() {
  return document.body;
}
""" :: forall e. Eff e Node

foreign import renderComponent """
function renderComponent(node) {
  return function(comp) {
    return function() {
      require('react').render(comp, node);
    };
  };
}
""" :: forall e. Node -> React -> Eff (renderReact :: ReactRenderEff |e) Unit

foreign import renderToBody """
function renderToBody(comp) {
  return function() {
    require('react').render(comp, document.body);
  };
}
""" :: forall e. React -> Eff (renderReact :: ReactRenderEff |e) Unit


foreign import refs """
function refs(react) {
  return function() {
    return react.refs;
  };
}
""" :: forall e. React -> Eff e Refs


foreign import atRef """
function atRef(refs) {
  return function(key) {
    return function() {
      var result = refs[key];
      if (!result) return new Data_Maybe.Nothing();
      else return Data_Maybe.Just.create(result);
    };
  };
}
""" :: forall e. Refs -> String -> Eff e (Maybe React)

getRef :: forall e. React -> String -> Eff e (Maybe React)
getRef react key = do
  refs <- refs react
  atRef refs key

infix 13 ::^
(::^) = getRef


-- TODO :: make replacing state safe
-- i.e. React ==> React s 
-- maybe replacing is not valid operationg

foreign import getState """
function getState(react) {
  return function() {
    return react.state;
  };
}
""" :: forall e s. React -> Eff e s

foreign import replaceStateCb_ """
function replaceStateCb_(react) {
  return function(state) {
    return function(cb) {
      return function() {
        react.replaceState(state, function() {
          return cb(react.state)();
        });
        return react;  
      };
    };
  };
}
""" :: forall e s a. React -> s -> (s -> Eff e a) -> Eff e React 

replaceStateCb :: forall e s a. React -> s -> (s -> Eff e a) -> Eff e (Eff e s)
replaceStateCb this state cb = do
  r <- replaceStateCb_ this state cb
  return $ getState this
  

replaceState :: forall e s. React -> s -> Eff e (Eff e s)
replaceState react state = replaceStateCb react state (const $ return unit)


foreign import setStateCb_ """
function setStateCb_(react) {
  return function(state) {
    return function(cb) {
      return function() {
        react.setState(state, function() {
          return cb(react.state)();
        });
        return react;
      };
    };
  };
}
""" :: forall e s a. React -> s -> (s -> Eff e a) -> Eff e React
setStateCb :: forall e s a. React -> s -> (s -> Eff e a) -> Eff e (Eff e s)
setStateCb this state cb = do
  r <- setStateCb_ this state cb
  return $ getState r
  
setState :: forall e s. React -> s -> Eff e (Eff e s)
setState react state = setStateCb react state (const $ return unit)

modifyStateCb :: forall e s a.
                 React -> (s -> s) -> (s -> Eff e a) -> Eff e (Eff e s)
modifyStateCb this mutator callback = do
  st <- getState this
  setStateCb this (mutator st) callback

modifyState this mutator = modifyStateCb this mutator (const $ return unit)
  

foreign import setPropsCb """
function setPropsCb(react) {
  return function(props) {
    return function(cb) {
      return function() {
        react.setProps(props, function() {
          return cb(react.props)();
        });
      };
    };
  };
}
""" :: forall e a. React -> Props -> (Props -> Eff e a) -> Eff e Unit

setProps this props = setPropsCb this props (const $ return unit)

modifyPropsCb :: forall e a.
                 React -> (Props -> Props) -> (Props -> Eff e a) -> Eff e Unit
modifyPropsCb this mutator cb = do
  let props = properties this
  setPropsCb this (mutator props) cb

modifyProps this mutator = modifyPropsCb this mutator (const $ return unit)

class Children a
instance reactChildren :: Children React
instance reactArrayChildren :: Children [React]


class ReactType a
instance reactTypeString :: ReactType String
instance reactTypeReactClass :: ReactType ReactClass
instance reactTypeReactClassEff :: ReactType (Eff e ReactClass)

foreign import mkEl """
function mkEl(name) {
  return function(prop) {
    return function(children) {
        var react = require('react');
        if (children && children.length == 1) {
          children = children[0];
        }
        if (typeof name == 'function') {
          name = name();
        }
        return react.createElement(name, prop, children);
    }
  }
}
""" :: forall children name. 
       name -> Props -> children -> React

foreign import textEl """
function textEl(str) {return str;}
""" :: String -> React

foreign import children """
function children(react) {
  var cs = react.props.children;
  if (!cs) return [];
  if (!cs.length) return [cs];
  return cs;
}
""" :: React -> [React]

foreign import properties """
function properties(react) {
  return react.props;
}
""" :: React -> Props


data ReactCfg name =
  ReactCfg {
    props :: Props,
    name :: name,
    children :: [Exists ReactCfg]
    }
  | Text String
  | Ready React

    
emptyCfg = ReactCfg{props: noprop, name: "", children: []}


foreign import decapsule """
function decapsule(f) {
  return function(fa) {
    return f(fa);
  };
}
""" :: forall f a r. (f a -> r) -> Exists f -> r


runCfg :: Exists ReactCfg -> React
runCfg exists =

  let processCfg cfg =
        case cfg of
          ReactCfg cfg ->
            let children = runCfg <$> reverse cfg.children
            in mkEl cfg.name cfg.props children
          Text str -> textEl str
          Ready react -> react

  in decapsule processCfg exists

addNewEl :: forall t. (ReactType t) => t -> State [Exists ReactCfg] Unit
addNewEl name =
  let cfg = mkExists $ ReactCfg{props: noprop, name: name, children: []}
  in modify $ \state -> cfg:state

inject :: React -> State [Exists ReactCfg] Unit
inject react =
  modify $ \state -> (mkExists $ Ready react):state

injects :: [React] -> State [Exists ReactCfg] Unit
injects reacts = do
  foldM (\unit react -> inject react) unit reacts

injectChildren :: React -> State [Exists ReactCfg] Unit
injectChildren react =
  injects $ children react


raw :: String -> State [Exists ReactCfg] Unit
raw content =
  modify $ \state -> (mkExists $ Text content):state

addProp :: Props -> State [Exists ReactCfg] Unit
addProp prop = do
  capsuled <- get
  let cfgs = (decapsule id) <$> capsuled
  case capsuled of
    [] -> return unit
    exists:xs ->
      case decapsule id exists of
        ReactCfg cfg -> do 
          let config = cfg {props = prop <> cfg.props}
              rcfg = mkExists $ ReactCfg config
          put $ rcfg:xs
        _ -> return unit
      

addChildren :: State [Exists ReactCfg] Unit -> State [Exists ReactCfg] Unit
addChildren childrenState = do
  let children = execState childrenState []
  capsuled <- get
  case capsuled of
    [] -> return unit
    exists:xs ->
      case decapsule id exists of
        ReactCfg cfg -> do 
          let config = cfg {children = children}
              rcfg = mkExists $ ReactCfg config
          put $ rcfg:xs
        _ -> return unit

runUI :: State [Exists ReactCfg] Unit -> Maybe React
runUI stated =
  case execState stated [] of
    [] -> Nothing
    cfg:_ -> Just $ runCfg cfg 

unsafeRunUI :: forall eff .State [Exists ReactCfg] Unit -> Eff eff React
unsafeRunUI stated =
  case execState stated [] of
    cfg:_ -> return $ runCfg cfg




(!) :: State [Exists ReactCfg] Unit ->
       Props ->
       State [Exists ReactCfg] Unit
(!) last prop = last >>= \_ -> addProp prop

($$) :: State [Exists ReactCfg] Unit  ->
        State [Exists ReactCfg] Unit ->
        State [Exists ReactCfg] Unit
($$) last stated = last >>= \_ -> addChildren stated

