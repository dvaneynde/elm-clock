module DigitalClock exposing (..)

import Html exposing (Html, div, text, program)
import Html.Attributes as HtmlAttr
import Time exposing (Time, second)
import Date
import Date.Format


view : Time -> Html msg
view time =
    div [HtmlAttr.style[("text-align","right"), ("width","600px"), ("padding-top","200px")]] [
            Html.text (Date.Format.format "%A, %B %d, %Y" (Date.fromTime time))
            , Html.br [] []
            , Html.span[HtmlAttr.style[("font-size","3em")]] [Html.text (Date.Format.format "%I:%M:%S" (Date.fromTime time))]
        ]