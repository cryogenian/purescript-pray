module Pray.Props.Html where

import Prelude hiding (id)
import Pray.Props

accept :: forall a. (Attribute a) => a -> Props
accept = mkProps "accept"

acceptCharset :: forall a. (Attribute a) => a -> Props
acceptCharset = mkProps "acceptCharset"

accessKey :: forall a. (Attribute a) => a -> Props
accessKey = mkProps "accessKey"

action :: forall a. (Attribute a) => a -> Props
action = mkProps "action"

allowFullScreen :: forall a. (Attribute a) => a -> Props
allowFullScreen = mkProps "allowFullScreen"

allowTransparency :: forall a. (Attribute a) => a -> Props
allowTransparency = mkProps "allowTransparency"

alt :: forall a. (Attribute a) => a -> Props
alt = mkProps "alt"

async :: forall a. (Attribute a) => a -> Props
async = mkProps "async"

autoComplete :: forall a. (Attribute a) => a -> Props
autoComplete = mkProps "autoComplete"

autoPlay :: forall a. (Attribute a) => a -> Props
autoPlay = mkProps "autoPlay"

cellPadding :: forall a. (Attribute a) => a -> Props
cellPadding = mkProps "cellPadding"

cellSpacing :: forall a. (Attribute a) => a -> Props
cellSpacing = mkProps "cellSpacing"

charSet :: forall a. (Attribute a) => a -> Props
charSet = mkProps "charSet"

checked :: forall a. (Attribute a) => a -> Props
checked = mkProps "checked"

classID :: forall a. (Attribute a) => a -> Props
classID = mkProps "classID"

className :: forall a. (Attribute a) => a -> Props
className = mkProps "className"

cols :: forall a. (Attribute a) => a -> Props
cols = mkProps "cols"

colSpan :: forall a. (Attribute a) => a -> Props
colSpan = mkProps "colSpan"

content :: forall a. (Attribute a) => a -> Props
content = mkProps "content"

contentEditable :: forall a. (Attribute a) => a -> Props
contentEditable = mkProps "contentEditable"

contextMenu :: forall a. (Attribute a) => a -> Props
contextMenu = mkProps "contextMenu"

controls :: forall a. (Attribute a) => a -> Props
controls = mkProps "controls"

coords :: forall a. (Attribute a) => a -> Props
coords = mkProps "coords"

crossOrigin :: forall a. (Attribute a) => a -> Props
crossOrigin = mkProps "crossOrigin"

dataProp :: forall a. (Attribute a) => a -> Props
dataProp = mkProps "data"

dateTime :: forall a. (Attribute a) => a -> Props
dateTime = mkProps "dateTime"

defer :: forall a. (Attribute a) => a -> Props
defer = mkProps "defer"

dir :: forall a. (Attribute a) => a -> Props
dir = mkProps "dir"

disabled :: forall a. (Attribute a) => a -> Props
disabled = mkProps "disabled"

download :: forall a. (Attribute a) => a -> Props
download = mkProps "download"

draggable :: forall a. (Attribute a) => a -> Props
draggable = mkProps "draggable"

encType :: forall a. (Attribute a) => a -> Props
encType = mkProps "encType"

form :: forall a. (Attribute a) => a -> Props
form = mkProps "form"

formNoValidate :: forall a. (Attribute a) => a -> Props
formNoValidate = mkProps "formNoValidate"

frameBorder :: forall a. (Attribute a) => a -> Props
frameBorder = mkProps "frameBorder"

height :: forall a. (Attribute a) => a -> Props
height = mkProps "height"

hidden :: forall a. (Attribute a) => a -> Props
hidden = mkProps "hidden"

href :: forall a. (Attribute a) => a -> Props
href = mkProps "href"

hrefLang :: forall a. (Attribute a) => a -> Props
hrefLang = mkProps "hrefLang"

htmlFor :: forall a. (Attribute a) => a -> Props
htmlFor = mkProps "htmlFor"

httpEquiv :: forall a. (Attribute a) => a -> Props
httpEquiv = mkProps "httpEquiv"

icon :: forall a. (Attribute a) => a -> Props
icon = mkProps "icon"

id :: forall a. (Attribute a) => a -> Props
id = mkProps "id"

label :: forall a. (Attribute a) => a -> Props
label = mkProps "label"

lang :: forall a. (Attribute a) => a -> Props
lang = mkProps "lang"

list :: forall a. (Attribute a) => a -> Props
list = mkProps "list"

loop :: forall a. (Attribute a) => a -> Props
loop = mkProps "loop"

manifest :: forall a. (Attribute a) => a -> Props
manifest = mkProps "manifest"

max :: forall a. (Attribute a) => a -> Props
max = mkProps "max"

maxLength :: forall a. (Attribute a) => a -> Props
maxLength = mkProps "maxLength"

media :: forall a. (Attribute a) => a -> Props
media = mkProps "media"

mediaGroup :: forall a. (Attribute a) => a -> Props
mediaGroup = mkProps "mediaGroup"

method :: forall a. (Attribute a) => a -> Props
method = mkProps "method"

min :: forall a. (Attribute a) => a -> Props
min = mkProps "min"

multiple :: forall a. (Attribute a) => a -> Props
multiple = mkProps "multiple"

muted :: forall a. (Attribute a) => a -> Props
muted = mkProps "muted"

name :: forall a. (Attribute a) => a -> Props
name = mkProps "name"

noValidate :: forall a. (Attribute a) => a -> Props
noValidate = mkProps "noValidate"

open :: forall a. (Attribute a) => a -> Props
open = mkProps "open"

pattern :: forall a. (Attribute a) => a -> Props
pattern = mkProps "pattern"

placeholder :: forall a. (Attribute a) => a -> Props
placeholder = mkProps "placeholder"

poster :: forall a. (Attribute a) => a -> Props
poster = mkProps "poster"

preload :: forall a. (Attribute a) => a -> Props
preload = mkProps "preload"

radioGroup :: forall a. (Attribute a) => a -> Props
radioGroup = mkProps "radioGroup"

readOnly :: forall a. (Attribute a) => a -> Props
readOnly = mkProps "readOnly"

rel :: forall a. (Attribute a) => a -> Props
rel = mkProps "rel"

required :: forall a. (Attribute a) => a -> Props
required = mkProps "required"

role :: forall a. (Attribute a) => a -> Props
role = mkProps "role"

rows :: forall a. (Attribute a) => a -> Props
rows = mkProps "rows"

rowSpan :: forall a. (Attribute a) => a -> Props
rowSpan = mkProps "rowSpan"

sandbox :: forall a. (Attribute a) => a -> Props
sandbox = mkProps "sandbox"

scope :: forall a. (Attribute a) => a -> Props
scope = mkProps "scope"

scrolling :: forall a. (Attribute a) => a -> Props
scrolling = mkProps "scrolling"

seamless :: forall a. (Attribute a) => a -> Props
seamless = mkProps "seamless"

selected :: forall a. (Attribute a) => a -> Props
selected = mkProps "selected"

shape :: forall a. (Attribute a) => a -> Props
shape = mkProps "shape"

size :: forall a. (Attribute a) => a -> Props
size = mkProps "size"

sizes :: forall a. (Attribute a) => a -> Props
sizes = mkProps "sizes"

span :: forall a. (Attribute a) => a -> Props
span = mkProps "span"

spellCheck :: forall a. (Attribute a) => a -> Props
spellCheck = mkProps "spellCheck"

src :: forall a. (Attribute a) => a -> Props
src = mkProps "src"

srcDoc :: forall a. (Attribute a) => a -> Props
srcDoc = mkProps "srcDoc"

srcSet :: forall a. (Attribute a) => a -> Props
srcSet = mkProps "srcSet"

start :: forall a. (Attribute a) => a -> Props
start = mkProps "start"

step :: forall a. (Attribute a) => a -> Props
step = mkProps "step"

style :: forall a. (Attribute a) => a -> Props
style = mkProps "style"

tabIndex :: forall a. (Attribute a) => a -> Props
tabIndex = mkProps "tabIndex"

target :: forall a. (Attribute a) => a -> Props
target = mkProps "target"

title :: forall a. (Attribute a) => a -> Props
title = mkProps "title"

typeProp :: forall a. (Attribute a) => a -> Props
typeProp = mkProps "type"

useMap :: forall a. (Attribute a) => a -> Props
useMap = mkProps "useMap"

value :: forall a. (Attribute a) => a -> Props
value = mkProps "value"

width :: forall a. (Attribute a) => a -> Props
width = mkProps "width"

wmode :: forall a. (Attribute a) => a -> Props
wmode = mkProps "wmode"
autoCapitalize :: forall a. (Attribute a) => a -> Props
autoCapitalize = mkProps "autoCapitalize"

autoCorrect :: forall a. (Attribute a) => a -> Props
autoCorrect = mkProps "autoCorrect"

property :: forall a. (Attribute a) => a -> Props
property = mkProps "property"

itemProp :: forall a. (Attribute a) => a -> Props
itemProp = mkProps "itemProp"

itemScope :: forall a. (Attribute a) => a -> Props
itemScope = mkProps "itemScope"

itemType :: forall a. (Attribute a) => a -> Props
itemType = mkProps "itemType"
