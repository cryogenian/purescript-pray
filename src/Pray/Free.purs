module Pray.Free where

import Control.Monad.Eff
import Control.Monad.ST
import Control.Monad.Free
import Data.Function
import Data.Coyoneda

import Pray.Props
import Pray.React


-- ^ s - состояние для этого компонента
data ComponentF s eff more =
  DisplayName String more
  | Render (React -> Eff eff React) more
  | InitialState s (s -> more)
  | DefaultProps Props more
  | Mixins [ComponentCfg]  more
  | WillMount (React -> Eff eff React) more
  | DidMount (React -> Eff eff React) more
  | WillReceiveProps (React -> Props -> Eff eff React) more
  | ShouldUpdate (React-> Props -> s -> Eff eff Boolean) more
  | WillUpdate (React-> Props -> s -> Eff eff React) more
  | DidUpdate (React-> Props -> s -> Eff eff React) more
  | WillUnmount (React-> Eff eff React) more 
  
type Component s eff more = FreeC (ComponentF s eff) more


display :: forall s eff. String -> Component s eff Unit
display name = liftFC $ DisplayName name unit

render :: forall s eff. (React -> Eff eff React) -> Component s eff Unit
render mutate = liftFC $ Render mutate unit

state :: forall s eff. s -> Component s eff s
state s = liftFC $ InitialState s id

props :: forall s eff. Props -> Component s eff Unit
props ps = liftFC $ DefaultProps ps unit

mixins :: forall s eff. [ComponentCfg] -> Component s eff Unit
mixins mxs = liftFC $ Mixins mxs unit

willMount :: forall s eff. (React -> Eff eff React) -> Component s eff Unit
willMount mutate = liftFC $ WillMount mutate unit

didMount :: forall s eff. (React -> Eff eff React) -> Component s eff Unit
didMount func = liftFC $ DidMount func unit

willReceiveProps :: forall s eff.
                    (React -> Props -> Eff eff React) -> Component s eff Unit
willReceiveProps func = liftFC $ WillReceiveProps func unit

shouldUpdate :: forall s eff.
                (React -> Props -> s -> Eff eff Boolean) ->
                Component s eff Unit
shouldUpdate func = liftFC $ ShouldUpdate func unit

willUpdate :: forall eff s.
              (React -> Props -> s -> Eff eff React) ->
              Component s eff Unit
willUpdate func = liftFC $ WillUpdate func unit

didUpdate :: forall s eff.
             (React -> Props -> s -> Eff eff React) ->
             Component s eff Unit
didUpdate func = liftFC $ DidUpdate func unit

willUnmount :: forall s eff. 
               (React -> Eff eff React) ->
               Component s eff Unit
willUnmount func = liftFC $ WillUnmount func unit


foreign import data ComponentCfg :: *

foreign import emptyComponent """
function emptyComponent() {
  return {};
}
""" :: forall e. Eff e ComponentCfg

foreign import addDisplayName """
function addDisplayName(cfg) {
  return function(name) {
    cfg.displayName = name;
    return cfg;
  }
}
""" :: ComponentCfg -> String -> ComponentCfg

foreign import addRender """
function addRender(cfg) {
  return function(func) {
    cfg.render = function() {return func(this)()};
    return cfg;
  }
}
""" :: forall eff. ComponentCfg -> Fn1 React (Eff eff React) -> ComponentCfg

foreign import addInitialState """
function addInitialState(cfg) {
  return function(state) {
    cfg.getInitialState = function() {
      return state;
    };
    return cfg;
  }
}
""" :: forall s. ComponentCfg -> s -> ComponentCfg

foreign import addDefaultProps """
function addDefaultProps(cfg) {
  return function(props) {
    cfg.getDefaultProps = function() {
      return props;
    };
    return cfg;
  }
}
""" :: ComponentCfg -> Props -> ComponentCfg

foreign import addMixins """
function addMixins(cfg) {
  return function(reacts) {
    cfg.mixins = reacts;
    return cfg;
  }
}
""" :: ComponentCfg -> [ComponentCfg] -> ComponentCfg

foreign import addWillMount """
function addWillMount(cfg) {
  return function(handler) {
    cfg.componentWillMount = function() {return handler(this)()};
    return cfg;
  }
}
""" :: forall eff. ComponentCfg -> Fn1 React (Eff eff React) -> ComponentCfg

foreign import addDidMount """
function addDidMount(cfg) {
  return function(handler) {
    cfg.componentDidMount = function() {return handler(this)()};
    return cfg;
  }
}
""" :: forall eff. ComponentCfg -> Fn1 React (Eff eff React) -> ComponentCfg

foreign import addWillReceiveProps """
function addWillReceiveProps(cfg) {
  return function(handler) {
    cfg.componentWillReceiveProps = function(props) {
      return handler(this, props)();
    };
    return cfg;
  }
}
""" :: forall eff.
       ComponentCfg -> Fn2 React Props (Eff eff React) -> ComponentCfg

foreign import addShouldUpdate """
function addShouldUpdate(cfg) {
  return function(handler) {
    cfg.shouldComponentUpdate = function(props, state) {
      return handler(this, props, state)();
    };
    return cfg;
  }
}
""" :: forall s eff. ComponentCfg ->
       Fn3 React Props s (Eff eff Boolean) ->
       ComponentCfg

foreign import addWillUpdate """
function addWillUpdate(cfg) {
  return function(handler) {
    cfg.componentWillUpdate = function(props, state) {
      return handler(this, props, state)();
    };
    return cfg;
  }
}
""" :: forall s eff. ComponentCfg ->
       Fn3 React Props s (Eff eff React) ->
       ComponentCfg

foreign import addDidUpdate """
function addDidUpdate(cfg) {
  return function(handler) {
    cfg.componentDidUpdate = function(props, state) {
      return handler(this, props, state)();
    };
    return cfg;
  }
}
""" :: forall s eff. ComponentCfg ->
       Fn3 React Props s (Eff eff React) -> 
       ComponentCfg

foreign import addWillUnmount """
function addWillUnmount(cfg) {
  return function(handler) {
    cfg.componentWillUnmount = function() {return handler(this)()};
    return cfg;
  }
}
""" :: forall eff. ComponentCfg -> Fn1 React (Eff eff React) -> ComponentCfg 

foreign import makeCls """
function makeCls(cfg) {
  var react = require('react');
  var cls = react.createClass(cfg);
  return cls;
}
""" :: ComponentCfg -> ReactClass


-- TODO: remove Eff (st: ST close) -> State or
-- something without effect because definign of
-- component class in general make little effects
interpret :: forall e s close a.
             STRef close ComponentCfg ->
             Natural (ComponentF s e) (Eff (st :: ST close|e))
interpret ref comand =
  let modify = modifySTRef ref in
  case comand of
    DisplayName name more -> do
      modify $ \cfg -> addDisplayName cfg name
      return more
    Render func more -> do
      modify $ \cfg -> addRender cfg (mkFn1 $ func)
      return more
    InitialState state k -> do
      modify $ \cfg -> addInitialState cfg state
      return $ k state
    DefaultProps props more -> do
      modify $ \cfg -> addDefaultProps cfg props
      return more
    Mixins mxs more -> do
      modify $ \cfg -> addMixins cfg mxs
      return more
    WillMount func more -> do
      modify $ \cfg -> addWillMount cfg (mkFn1 $ func)
      return more
    DidMount func more -> do
      modify $ \cfg -> addDidMount cfg (mkFn1 $ func)
      return more
    WillReceiveProps func more -> do
      modify $ \cfg -> addWillReceiveProps cfg ( mkFn2 $ func)
      return more
    ShouldUpdate func more -> do
      modify $ \cfg -> addShouldUpdate cfg (mkFn3 $ func)
      return more
    WillUpdate func more -> do
      modify $ \cfg -> addWillUpdate cfg (mkFn3 $ func)
      return more
    DidUpdate func more -> do
      modify $ \cfg -> addDidUpdate cfg (mkFn3 $ func)
      return more
    WillUnmount func more -> do
      modify $ \cfg -> addWillUnmount cfg (mkFn1 $ func)
      return more

defineMixin :: forall a s e close.
               Component s e a -> Eff (st :: ST close|e) ComponentCfg 
defineMixin freeC = do 
  empty <- emptyComponent
  acc <- newSTRef empty
  goEffC (interpret acc) freeC

  readSTRef acc

defineClass freeC =
  makeCls <$> defineMixin freeC

defineFactory freeC =
  mkEl $ defineClass freeC


