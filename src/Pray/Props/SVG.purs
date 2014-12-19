module Pray.Props.SVG where 
import Pray.Props


cx :: forall a. (Attribute a) => a -> Props
cx = mkProps "cx"

cy :: forall a. (Attribute a) => a -> Props
cy = mkProps "cy"

d :: forall a. (Attribute a) => a -> Props
d = mkProps "d"

dx :: forall a. (Attribute a) => a -> Props
dx = mkProps "dx"

dy :: forall a. (Attribute a) => a -> Props
dy = mkProps "dy"

fill :: forall a. (Attribute a) => a -> Props
fill = mkProps "fill"

fillOpacity :: forall a. (Attribute a) => a -> Props
fillOpacity = mkProps "fillOpacity"

fontFamily :: forall a. (Attribute a) => a -> Props
fontFamily = mkProps "fontFamily"

fontSize :: forall a. (Attribute a) => a -> Props
fontSize = mkProps "fontSize"

fx :: forall a. (Attribute a) => a -> Props
fx = mkProps "fx"

fy :: forall a. (Attribute a) => a -> Props
fy = mkProps "fy"

gradientTransform :: forall a. (Attribute a) => a -> Props
gradientTransform = mkProps "gradientTransform"

gradientUnits :: forall a. (Attribute a) => a -> Props
gradientUnits = mkProps "gradientUnits"

markerEnd :: forall a. (Attribute a) => a -> Props
markerEnd = mkProps "markerEnd"

markerMid :: forall a. (Attribute a) => a -> Props
markerMid = mkProps "markerMid"

markerStart :: forall a. (Attribute a) => a -> Props
markerStart = mkProps "markerStart"

offset :: forall a. (Attribute a) => a -> Props
offset = mkProps "offset"

opacity :: forall a. (Attribute a) => a -> Props
opacity = mkProps "opacity"

patternContentUnits :: forall a. (Attribute a) => a -> Props
patternContentUnits = mkProps "patternContentUnits"

patternUnits :: forall a. (Attribute a) => a -> Props
patternUnits = mkProps "patternUnits"

points :: forall a. (Attribute a) => a -> Props
points = mkProps "points"

preserveAspectRatio :: forall a. (Attribute a) => a -> Props
preserveAspectRatio = mkProps "preserveAspectRatio"

r :: forall a. (Attribute a) => a -> Props
r = mkProps "r"

rx :: forall a. (Attribute a) => a -> Props
rx = mkProps "rx"

ry :: forall a. (Attribute a) => a -> Props
ry = mkProps "ry"

spreadMethod :: forall a. (Attribute a) => a -> Props
spreadMethod = mkProps "spreadMethod"

stopColor :: forall a. (Attribute a) => a -> Props
stopColor = mkProps "stopColor"

stopOpacity :: forall a. (Attribute a) => a -> Props
stopOpacity = mkProps "stopOpacity"

stroke :: forall a. (Attribute a) => a -> Props
stroke = mkProps "stroke"

strokeDasharray :: forall a. (Attribute a) => a -> Props
strokeDasharray = mkProps "strokeDasharray"

strokeLinecap :: forall a. (Attribute a) => a -> Props
strokeLinecap = mkProps "strokeLinecap"

strokeOpacity :: forall a. (Attribute a) => a -> Props
strokeOpacity = mkProps "strokeOpacity"

strokeWidth :: forall a. (Attribute a) => a -> Props
strokeWidth = mkProps "strokeWidth"

textAnchor :: forall a. (Attribute a) => a -> Props
textAnchor = mkProps "textAnchor"

transform :: forall a. (Attribute a) => a -> Props
transform = mkProps "transform"

version :: forall a. (Attribute a) => a -> Props
version = mkProps "version"

viewBox :: forall a. (Attribute a) => a -> Props
viewBox = mkProps "viewBox"

x1 :: forall a. (Attribute a) => a -> Props
x1 = mkProps "x1"

x2 :: forall a. (Attribute a) => a -> Props
x2 = mkProps "x2"

x :: forall a. (Attribute a) => a -> Props
x = mkProps "x"

y1 :: forall a. (Attribute a) => a -> Props
y1 = mkProps "y1"

y2 :: forall a. (Attribute a) => a -> Props
y2 = mkProps "y2"

y :: forall a. (Attribute a) => a -> Props
y = mkProps "y"
