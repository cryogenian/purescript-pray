# Module Documentation

## Module Main

### Values


    alert :: forall a e. a -> Eff e Unit


    changeSuccess :: forall e. React -> FormEvent -> Eff e Unit


    enterPressed :: forall e. React -> KeyboardEvent -> Eff e Unit


    onload :: forall e. Eff e Unit -> Eff e Unit


    todoChanged :: forall e. React -> FormEvent -> Eff e Unit


    todoSubmited :: forall e. React -> String -> FormEvent -> Eff e Unit


## Module Pray.Event

### Types


    data ClipboardEvent :: *


    data FocusEvent :: *


    data FormEvent :: *


    data KeyboardEvent :: *


    data MouseEvent :: *


    data SyntheticEventEff :: !


    data TouchEvent :: *


    data UIEvent :: *


    data WheelEvent :: *


### Type Classes


    class (SyntheticEvent event) <= InputEvent event where


    class SyntheticEvent event where


### Type Class Instances


    instance clipboardSyntheticEvent :: SyntheticEvent ClipboardEvent


    instance focusSyntheticEvent :: SyntheticEvent FocusEvent


    instance formSyntheticEvent :: SyntheticEvent FormEvent


    instance keyboardInputEvent :: InputEvent KeyboardEvent


    instance keyboardSyntheticEvent :: SyntheticEvent KeyboardEvent


    instance mouseInputEvent :: InputEvent MouseEvent


    instance mouseSyntheticEvent :: SyntheticEvent MouseEvent


    instance touchInputEvent :: InputEvent TouchEvent


    instance touchSyntheticEvent :: SyntheticEvent TouchEvent


    instance uiSyntheticEvent :: SyntheticEvent UIEvent


    instance wheelSyntheticEvent :: SyntheticEvent WheelEvent


### Values

    ------------------------------------------------------------------------------
                                   Input
    ------------------------------------------------------------------------------

    altKey :: forall ev. (InputEvent ev) => ev -> Boolean

    ------------------------------------------------------------------------------
                                   Common
    ------------------------------------------------------------------------------

    bubbles :: forall ev. (SyntheticEvent ev) => ev -> Boolean

    ------------------------------------------------------------------------------
                                   Mouse
    ------------------------------------------------------------------------------

    button :: MouseEvent -> Number


    buttons :: MouseEvent -> Number


    cancelable :: forall ev. (SyntheticEvent ev) => ev -> Boolean

     Another functions with unknown types of DOM

    changedTouches :: forall domTouchList. TouchEvent -> domTouchList

    ------------------------------------------------------------------------------
                                  Keyboard
    ------------------------------------------------------------------------------

    charCode :: KeyboardEvent -> Number


    clientX :: MouseEvent -> Number


    clientY :: MouseEvent -> Number

    ------------------------------------------------------------------------------
                                   Clipboard 
    ------------------------------------------------------------------------------

    clipboardData :: forall domTransfer. ClipboardEvent -> domTransfer


    ctrlKey :: forall ev. (InputEvent ev) => ev -> Boolean

     Do not know what kind of Dom Library will be used

    currentTarget :: forall ev dom. (SyntheticEvent ev) => ev -> dom


    defaultPrevented :: forall ev. (SyntheticEvent ev) => ev -> Boolean

    ------------------------------------------------------------------------------
                                   Wheel
    ------------------------------------------------------------------------------

    deltaMode :: WheelEvent -> Number


    deltaX :: WheelEvent -> Number


    deltaY :: WheelEvent -> Number


    deltaZ :: WheelEvent -> Number

    ------------------------------------------------------------------------------
                                  UI
    ------------------------------------------------------------------------------

    detail :: UIEvent -> Number


    eventPhase :: forall ev. (SyntheticEvent ev) => ev -> Number


    getModifierState :: forall ev. (InputEvent ev) => ev -> String -> Boolean

    ------------------------------------------------------------------------------
                                   Form
    ------------------------------------------------------------------------------

    getValue :: forall a. FormEvent -> a


    isTrusted :: forall ev. (SyntheticEvent ev) => ev -> Boolean


    key :: KeyboardEvent -> String


    keyCode :: KeyboardEvent -> Number


    locale :: KeyboardEvent -> String


    location :: KeyboardEvent -> Number


    metaKey :: forall ev. (InputEvent ev) => ev -> Boolean

     Do not know what kind of DOM library will be used

    nativeEvent :: forall native ev. (SyntheticEvent ev) => ev -> native


    pageX :: MouseEvent -> Number


    pageY :: MouseEvent -> Number


    preventDefault :: forall ev e. (SyntheticEvent ev) => ev -> Eff e Unit

    ------------------------------------------------------------------------------
                                  Focus
    ------------------------------------------------------------------------------
     Do not know what is DOMEVentTarget

    relatedTarget :: forall domEventTarget. FocusEvent -> domEventTarget


    repeat :: KeyboardEvent -> Boolean


    screenX :: MouseEvent -> Number


    screenY :: MouseEvent -> Number


    shiftKey :: forall ev. (InputEvent ev) => ev -> Boolean


    stopPropagation :: forall ev e. (SyntheticEvent ev) => ev -> Eff e Unit

     Do not know DOM library

    target :: forall ev dom. (SyntheticEvent ev) => ev -> dom


    targetTouches :: forall domTouchList. TouchEvent -> domTouchList


    timeStamp :: forall ev. (SyntheticEvent ev) => ev -> JSDate


    touches :: forall domTouchList. TouchEvent -> domTouchList


    turnOffTouchEvents :: forall e. Eff e Unit

    ------------------------------------------------------------------------------
                                  Touch
    ------------------------------------------------------------------------------

    turnOnTouchEvents :: forall e. Eff e Unit


    typeString :: forall ev. (SyntheticEvent ev) => ev -> String


    view :: forall domAbstractView. UIEvent -> domAbstractView


    which :: KeyboardEvent -> Number


## Module Pray.Free

### Types


    type Component s eff more = FreeC (ComponentF s eff) more


    data ComponentCfg :: *

     ^ s - состояние для этого компонента

    data ComponentF s eff more where
      DisplayName :: String -> more -> ComponentF s eff more
      Render :: (React -> Eff eff React) -> more -> ComponentF s eff more
      InitialState :: s -> (s -> more) -> ComponentF s eff more
      DefaultProps :: Props -> more -> ComponentF s eff more
      Mixins :: [ComponentCfg] -> more -> ComponentF s eff more
      WillMount :: (React -> Eff eff React) -> more -> ComponentF s eff more
      DidMount :: (React -> Eff eff React) -> more -> ComponentF s eff more
      WillReceiveProps :: (React -> Props -> Eff eff React) -> more -> ComponentF s eff more
      ShouldUpdate :: (React -> Props -> s -> Eff eff Boolean) -> more -> ComponentF s eff more
      WillUpdate :: (React -> Props -> s -> Eff eff React) -> more -> ComponentF s eff more
      DidUpdate :: (React -> Props -> s -> Eff eff React) -> more -> ComponentF s eff more
      WillUnmount :: (React -> Eff eff React) -> more -> ComponentF s eff more


### Values


    addDefaultProps :: ComponentCfg -> Props -> ComponentCfg


    addDidMount :: forall eff. ComponentCfg -> Fn1 React (Eff eff React) -> ComponentCfg


    addDidUpdate :: forall s eff. ComponentCfg -> Fn3 React Props s (Eff eff React) -> ComponentCfg


    addDisplayName :: ComponentCfg -> String -> ComponentCfg


    addInitialState :: forall s. ComponentCfg -> s -> ComponentCfg


    addMixins :: ComponentCfg -> [ComponentCfg] -> ComponentCfg


    addRender :: forall eff. ComponentCfg -> Fn1 React (Eff eff React) -> ComponentCfg


    addShouldUpdate :: forall s eff. ComponentCfg -> Fn3 React Props s (Eff eff Boolean) -> ComponentCfg


    addWillMount :: forall eff. ComponentCfg -> Fn1 React (Eff eff React) -> ComponentCfg


    addWillReceiveProps :: forall eff. ComponentCfg -> Fn2 React Props (Eff eff React) -> ComponentCfg


    addWillUnmount :: forall eff. ComponentCfg -> Fn1 React (Eff eff React) -> ComponentCfg


    addWillUpdate :: forall s eff. ComponentCfg -> Fn3 React Props s (Eff eff React) -> ComponentCfg


    defineMixin :: forall a s e close. Component s e a -> Eff (st :: ST close | e) ComponentCfg


    didMount :: forall s eff. (React -> Eff eff React) -> Component s eff Unit


    didUpdate :: forall s eff. (React -> Props -> s -> Eff eff React) -> Component s eff Unit


    display :: forall s eff. String -> Component s eff Unit


    emptyComponent :: forall e. Eff e ComponentCfg

     TODO: remove Eff (st: ST close) -> State or
     something without effect because definign of
     component class in general make little effects

    interpret :: forall e s close a. STRef close ComponentCfg -> Natural (ComponentF s e) (Eff (st :: ST close | e))


    makeCls :: ComponentCfg -> ReactClass


    mixins :: forall s eff. [ComponentCfg] -> Component s eff Unit


    props :: forall s eff. Props -> Component s eff Unit


    render :: forall s eff. (React -> Eff eff React) -> Component s eff Unit


    shouldUpdate :: forall s eff. (React -> Props -> s -> Eff eff Boolean) -> Component s eff Unit


    state :: forall s eff. s -> Component s eff s


    willMount :: forall s eff. (React -> Eff eff React) -> Component s eff Unit


    willReceiveProps :: forall s eff. (React -> Props -> Eff eff React) -> Component s eff Unit


    willUnmount :: forall s eff. (React -> Eff eff React) -> Component s eff Unit


    willUpdate :: forall eff s. (React -> Props -> s -> Eff eff React) -> Component s eff Unit


## Module Pray.Props

### Types


    data Props :: *


### Type Classes


    class Attribute a where


### Type Class Instances


    instance effAttribute :: Attribute (Eff e a)


    instance fn1Attribute :: Attribute (Fn1 a b)


    instance fn2Attribute :: Attribute (Fn2 a b c)


    instance fn3Attribute :: Attribute (Fn3 a b c d)


    instance fn4Attribute :: Attribute (Fn4 a b c d e)


    instance functionAttribute :: Attribute (a -> b)


    instance monoidProp :: Monoid Props


    instance numberAttribute :: Attribute Number


    instance semigroupProp :: Semigroup Props


    instance stringAttribute :: Attribute String


### Values


    (<<-) :: forall a. (Attribute a) => String -> a -> Props


    (^:) :: forall a. Props -> String -> a


    atProps :: forall a. String -> Props -> a


    mkProps :: forall a. (Attribute a) => String -> a -> Props


    noprop :: Props


    propsAppend :: Props -> Props -> Props


    propsEmpty :: Props


## Module Pray.React

### Types


    data React :: *


    data ReactCfg name where
      ReactCfg :: { children :: [Exists ReactCfg], name :: name, props :: Props } -> ReactCfg name
      Text :: String -> ReactCfg name
      Ready :: React -> ReactCfg name


    data ReactClass :: *


    data ReactRenderEff :: !


    data Refs :: *


### Type Classes


    class Children a where


    class ReactType a where


### Type Class Instances


    instance reactArrayChildren :: Children [React]


    instance reactAttribute :: Attribute React


    instance reactChildren :: Children React


    instance reactTypeReactClass :: ReactType ReactClass


    instance reactTypeReactClassEff :: ReactType (Eff e ReactClass)


    instance reactTypeString :: ReactType String


### Values


    (!) :: State [Exists ReactCfg] Unit -> Props -> State [Exists ReactCfg] Unit


    ($$) :: State [Exists ReactCfg] Unit -> State [Exists ReactCfg] Unit -> State [Exists ReactCfg] Unit


    addChildren :: State [Exists ReactCfg] Unit -> State [Exists ReactCfg] Unit


    addNewEl :: forall t. (ReactType t) => t -> State [Exists ReactCfg] Unit


    addProp :: Props -> State [Exists ReactCfg] Unit


    atRef :: forall e. Refs -> String -> Eff e (Maybe React)


    children :: React -> [React]


    decapsule :: forall f a r. (f a -> r) -> Exists f -> r


    documentBody :: forall e. Eff e Node


    getRef :: forall e. React -> String -> Eff e (Maybe React)

     TODO :: make replacing state safe
     i.e. React ==> React s 
     maybe replacing is not valid operationg

    getState :: forall e s. React -> Eff e s


    inject :: React -> State [Exists ReactCfg] Unit


    injectChildren :: React -> State [Exists ReactCfg] Unit


    injects :: [React] -> State [Exists ReactCfg] Unit


    mkEl :: forall children name. name -> Props -> children -> React


    modifyPropsCb :: forall e a. React -> (Props -> Props) -> (Props -> Eff e a) -> Eff e Unit


    modifyStateCb :: forall e s a. React -> (s -> s) -> (s -> Eff e a) -> Eff e (Eff e s)


    properties :: React -> Props


    raw :: String -> State [Exists ReactCfg] Unit


    refs :: forall e. React -> Eff e Refs


    renderComponent :: forall e. Node -> React -> Eff (renderReact :: ReactRenderEff | e) Unit


    renderToBody :: forall e. React -> Eff (renderReact :: ReactRenderEff | e) Unit


    replaceState :: forall e s. React -> s -> Eff e (Eff e s)


    replaceStateCb :: forall e s a. React -> s -> (s -> Eff e a) -> Eff e (Eff e s)


    replaceStateCb_ :: forall e s a. React -> s -> (s -> Eff e a) -> Eff e React


    runCfg :: Exists ReactCfg -> React


    runUI :: State [Exists ReactCfg] Unit -> Maybe React


    setPropsCb :: forall e a. React -> Props -> (Props -> Eff e a) -> Eff e Unit


    setState :: forall e s. React -> s -> Eff e (Eff e s)


    setStateCb :: forall e s a. React -> s -> (s -> Eff e a) -> Eff e (Eff e s)


    setStateCb_ :: forall e s a. React -> s -> (s -> Eff e a) -> Eff e React


    textEl :: String -> React


    unsafeRunUI :: forall eff. State [Exists ReactCfg] Unit -> Eff eff React


## Module Pray.Props.Handler

### Types

    ------------------------------------------------------------------------------
                                   Common
    ------------------------------------------------------------------------------

    type EEF e = Eff (synthetic :: SyntheticEventEff | e) Unit

    ------------------------------------------------------------------------------
                                   Mouse
    ------------------------------------------------------------------------------
     Mouse Handler Setter :)

    type MHS e = (MouseEvent -> EEF e) -> Props

    ------------------------------------------------------------------------------
                                   Touch
    ------------------------------------------------------------------------------
     Touch Handler Setter 

    type THS e = (TouchEvent -> EEF e) -> Props


### Values


    mkHandler :: forall e ev. (SyntheticEvent ev) => String -> (ev -> EEF e) -> Props


    onBlur :: forall e. (FocusEvent -> EEF e) -> Props

    ------------------------------------------------------------------------------
                                   Form
    ------------------------------------------------------------------------------

    onChange :: forall e. (FormEvent -> EEF e) -> Props


    onClick :: forall e. MHS e

    ------------------------------------------------------------------------------
                                   Clipboard
    ------------------------------------------------------------------------------

    onCopy :: forall e. (ClipboardEvent -> EEF e) -> Props


    onCut :: forall e. (ClipboardEvent -> EEF e) -> Props


    onDoubleClick :: forall e. MHS e


    onDrag :: forall e. MHS e


    onDragEnd :: forall e. MHS e


    onDragEnter :: forall e. MHS e


    onDragExit :: forall e. MHS e


    onDragLeave :: forall e. MHS e


    onDragOver :: forall e. MHS e


    onDragStart :: forall e. MHS e


    onDrop :: forall e. MHS e

    ------------------------------------------------------------------------------
                                   Focus
    ------------------------------------------------------------------------------

    onFocus :: forall e. (FocusEvent -> EEF e) -> Props


    onInput :: forall e. (FormEvent -> EEF e) -> Props

    ------------------------------------------------------------------------------
                                   Keyboard
    ------------------------------------------------------------------------------

    onKeyDown :: forall e. (KeyboardEvent -> EEF e) -> Props


    onKeyPress :: forall e. (KeyboardEvent -> EEF e) -> Props


    onKeyUp :: forall e. (KeyboardEvent -> EEF e) -> Props


    onMouseDown :: forall e. MHS e


    onMouseEnter :: forall e. MHS e


    onMouseLeave :: forall e. MHS e


    onMouseMove :: forall e. MHS e


    onMouseOut :: forall e. MHS e


    onMouseOver :: forall e. MHS e


    onMouseUp :: forall e. MHS e


    onPaste :: forall e. (ClipboardEvent -> EEF e) -> Props

    ------------------------------------------------------------------------------
                                   UI
    ------------------------------------------------------------------------------

    onScroll :: forall e. (UIEvent -> EEF e) -> Props


    onSubmit :: forall e. (FormEvent -> EEF e) -> Props


    onTouchCancel :: forall e. THS e


    onTouchEnd :: forall e. THS e


    onTouchMove :: forall e. THS e


    onTouchStart :: forall e. THS e

    ------------------------------------------------------------------------------
                                   Wheel
    ------------------------------------------------------------------------------

    onWheel :: forall e. (WheelEvent -> EEF e) -> Props


    toHandler :: forall e ev. (SyntheticEvent ev) => (ev -> EEF e) -> EEF e


## Module Pray.Props.Html

### Values


    accept :: forall a. (Attribute a) => a -> Props


    acceptCharset :: forall a. (Attribute a) => a -> Props


    accessKey :: forall a. (Attribute a) => a -> Props


    action :: forall a. (Attribute a) => a -> Props


    allowFullScreen :: forall a. (Attribute a) => a -> Props


    allowTransparency :: forall a. (Attribute a) => a -> Props


    alt :: forall a. (Attribute a) => a -> Props


    async :: forall a. (Attribute a) => a -> Props


    autoCapitalize :: forall a. (Attribute a) => a -> Props


    autoComplete :: forall a. (Attribute a) => a -> Props


    autoCorrect :: forall a. (Attribute a) => a -> Props


    autoPlay :: forall a. (Attribute a) => a -> Props


    cellPadding :: forall a. (Attribute a) => a -> Props


    cellSpacing :: forall a. (Attribute a) => a -> Props


    charSet :: forall a. (Attribute a) => a -> Props


    checked :: forall a. (Attribute a) => a -> Props


    classID :: forall a. (Attribute a) => a -> Props


    className :: forall a. (Attribute a) => a -> Props


    colSpan :: forall a. (Attribute a) => a -> Props


    cols :: forall a. (Attribute a) => a -> Props


    content :: forall a. (Attribute a) => a -> Props


    contentEditable :: forall a. (Attribute a) => a -> Props


    contextMenu :: forall a. (Attribute a) => a -> Props


    controls :: forall a. (Attribute a) => a -> Props


    coords :: forall a. (Attribute a) => a -> Props


    crossOrigin :: forall a. (Attribute a) => a -> Props


    dataProp :: forall a. (Attribute a) => a -> Props


    dateTime :: forall a. (Attribute a) => a -> Props


    defer :: forall a. (Attribute a) => a -> Props


    dir :: forall a. (Attribute a) => a -> Props


    disabled :: forall a. (Attribute a) => a -> Props


    download :: forall a. (Attribute a) => a -> Props


    draggable :: forall a. (Attribute a) => a -> Props


    encType :: forall a. (Attribute a) => a -> Props


    form :: forall a. (Attribute a) => a -> Props


    formNoValidate :: forall a. (Attribute a) => a -> Props


    frameBorder :: forall a. (Attribute a) => a -> Props


    height :: forall a. (Attribute a) => a -> Props


    hidden :: forall a. (Attribute a) => a -> Props


    href :: forall a. (Attribute a) => a -> Props


    hrefLang :: forall a. (Attribute a) => a -> Props


    htmlFor :: forall a. (Attribute a) => a -> Props


    httpEquiv :: forall a. (Attribute a) => a -> Props


    icon :: forall a. (Attribute a) => a -> Props


    id :: forall a. (Attribute a) => a -> Props


    itemProp :: forall a. (Attribute a) => a -> Props


    itemScope :: forall a. (Attribute a) => a -> Props


    itemType :: forall a. (Attribute a) => a -> Props


    label :: forall a. (Attribute a) => a -> Props


    lang :: forall a. (Attribute a) => a -> Props


    list :: forall a. (Attribute a) => a -> Props


    loop :: forall a. (Attribute a) => a -> Props


    manifest :: forall a. (Attribute a) => a -> Props


    max :: forall a. (Attribute a) => a -> Props


    maxLength :: forall a. (Attribute a) => a -> Props


    media :: forall a. (Attribute a) => a -> Props


    mediaGroup :: forall a. (Attribute a) => a -> Props


    method :: forall a. (Attribute a) => a -> Props


    min :: forall a. (Attribute a) => a -> Props


    multiple :: forall a. (Attribute a) => a -> Props


    muted :: forall a. (Attribute a) => a -> Props


    name :: forall a. (Attribute a) => a -> Props


    noValidate :: forall a. (Attribute a) => a -> Props


    open :: forall a. (Attribute a) => a -> Props


    pattern :: forall a. (Attribute a) => a -> Props


    placeholder :: forall a. (Attribute a) => a -> Props


    poster :: forall a. (Attribute a) => a -> Props


    preload :: forall a. (Attribute a) => a -> Props


    property :: forall a. (Attribute a) => a -> Props


    radioGroup :: forall a. (Attribute a) => a -> Props


    readOnly :: forall a. (Attribute a) => a -> Props


    rel :: forall a. (Attribute a) => a -> Props


    required :: forall a. (Attribute a) => a -> Props


    role :: forall a. (Attribute a) => a -> Props


    rowSpan :: forall a. (Attribute a) => a -> Props


    rows :: forall a. (Attribute a) => a -> Props


    sandbox :: forall a. (Attribute a) => a -> Props


    scope :: forall a. (Attribute a) => a -> Props


    scrolling :: forall a. (Attribute a) => a -> Props


    seamless :: forall a. (Attribute a) => a -> Props


    selected :: forall a. (Attribute a) => a -> Props


    shape :: forall a. (Attribute a) => a -> Props


    size :: forall a. (Attribute a) => a -> Props


    sizes :: forall a. (Attribute a) => a -> Props


    span :: forall a. (Attribute a) => a -> Props


    spellCheck :: forall a. (Attribute a) => a -> Props


    src :: forall a. (Attribute a) => a -> Props


    srcDoc :: forall a. (Attribute a) => a -> Props


    srcSet :: forall a. (Attribute a) => a -> Props


    start :: forall a. (Attribute a) => a -> Props


    step :: forall a. (Attribute a) => a -> Props


    style :: forall a. (Attribute a) => a -> Props


    tabIndex :: forall a. (Attribute a) => a -> Props


    target :: forall a. (Attribute a) => a -> Props


    title :: forall a. (Attribute a) => a -> Props


    typeProp :: forall a. (Attribute a) => a -> Props


    useMap :: forall a. (Attribute a) => a -> Props


    value :: forall a. (Attribute a) => a -> Props


    width :: forall a. (Attribute a) => a -> Props


    wmode :: forall a. (Attribute a) => a -> Props


## Module Pray.Props.SVG

### Values


    cx :: forall a. (Attribute a) => a -> Props


    cy :: forall a. (Attribute a) => a -> Props


    d :: forall a. (Attribute a) => a -> Props


    dx :: forall a. (Attribute a) => a -> Props


    dy :: forall a. (Attribute a) => a -> Props


    fill :: forall a. (Attribute a) => a -> Props


    fillOpacity :: forall a. (Attribute a) => a -> Props


    fontFamily :: forall a. (Attribute a) => a -> Props


    fontSize :: forall a. (Attribute a) => a -> Props


    fx :: forall a. (Attribute a) => a -> Props


    fy :: forall a. (Attribute a) => a -> Props


    gradientTransform :: forall a. (Attribute a) => a -> Props


    gradientUnits :: forall a. (Attribute a) => a -> Props


    markerEnd :: forall a. (Attribute a) => a -> Props


    markerMid :: forall a. (Attribute a) => a -> Props


    markerStart :: forall a. (Attribute a) => a -> Props


    offset :: forall a. (Attribute a) => a -> Props


    opacity :: forall a. (Attribute a) => a -> Props


    patternContentUnits :: forall a. (Attribute a) => a -> Props


    patternUnits :: forall a. (Attribute a) => a -> Props


    points :: forall a. (Attribute a) => a -> Props


    preserveAspectRatio :: forall a. (Attribute a) => a -> Props


    r :: forall a. (Attribute a) => a -> Props


    rx :: forall a. (Attribute a) => a -> Props


    ry :: forall a. (Attribute a) => a -> Props


    spreadMethod :: forall a. (Attribute a) => a -> Props


    stopColor :: forall a. (Attribute a) => a -> Props


    stopOpacity :: forall a. (Attribute a) => a -> Props


    stroke :: forall a. (Attribute a) => a -> Props


    strokeDasharray :: forall a. (Attribute a) => a -> Props


    strokeLinecap :: forall a. (Attribute a) => a -> Props


    strokeOpacity :: forall a. (Attribute a) => a -> Props


    strokeWidth :: forall a. (Attribute a) => a -> Props


    textAnchor :: forall a. (Attribute a) => a -> Props


    transform :: forall a. (Attribute a) => a -> Props


    version :: forall a. (Attribute a) => a -> Props


    viewBox :: forall a. (Attribute a) => a -> Props


    x :: forall a. (Attribute a) => a -> Props


    x1 :: forall a. (Attribute a) => a -> Props


    x2 :: forall a. (Attribute a) => a -> Props


    y :: forall a. (Attribute a) => a -> Props


    y1 :: forall a. (Attribute a) => a -> Props


    y2 :: forall a. (Attribute a) => a -> Props


## Module Pray.Props.Special

### Values


    key :: forall a. (Attribute a) => a -> Props


    ref :: String -> Props


## Module Pray.React.Html

## Module Pray.React.SVG


