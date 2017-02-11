module AnalogClock exposing (view)

import Html exposing (Html, div, text, program)
import Html.Attributes as HtmlAttr
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Time exposing (Time, second)
import Date
import Date.Format


view : Time -> Html msg
view time =
        div [HtmlAttr.style [("float","left")] ] [
            svg [ viewBox "0 0 100 100", width "300px" ]
                [ g [ transform "translate(50,50)" ]
                    (List.concat
                        [ [ circle [ cx "0", cy "0", r "48", fill "white", stroke "#333" ] [] ]
                        , List.map minor (List.range 0 59)
                        , List.map major (List.range 0 11)
                        , [ hoursHand time
                          , minutesHand time
                          , secondsHand time
                          ]
                        ]
                    )
                ]
        ]

secondsHand : Time -> Svg msg
secondsHand time =
    let
        rotation =
            (floor (Time.inSeconds time)) % 60 * 6

        rotationString =
            "rotate(" ++ (toString rotation) ++ ")"
    in
        g [ transform rotationString ]
            [ line [ y1 "10", y2 "-38", stroke "#B40000" ] []
            , line [ y1 "10", y2 "2", stroke "#B40000", strokeWidth "3" ] []
            ]


minutesHand : Time -> Svg msg
minutesHand time =
    let
        rotation =
            (floor (Time.inMinutes time)) % 60 * 6
    in
        g [ transform ( "rotate(" ++ (toString rotation) ++ ")" ) ]
            [ line [ y1 "10", y2 "-38", stroke "#666" ] []
            ]


hoursHand : Time -> Svg msg
hoursHand time =
    let
        rotation =
            (((floor (Time.inHours time)) + 1) % 12) * 30
    in
        g [ transform ( "rotate(" ++ (toString rotation) ++ ")" ) ]
            [ line [ y1 "5", y2 "-24", stroke "#333" ] []
            ]


minor : Int -> Svg msg
minor i =
    let
        rotation =
            360 * (toFloat i) / 60

        rotationString =
            "rotate( " ++ (toString rotation) ++ " )"
    in
        line [ y1 "42", y2 "45", transform rotationString, stroke "#999", strokeWidth "0.5" ] []


major : Int -> Svg msg
major i =
    let
        rotation =
            360 * (toFloat i) / 12

        rotationString =
            "rotate( " ++ (toString rotation) ++ " )"
    in
        line [ y1 "35", y2 "45", transform rotationString, stroke "#333", strokeWidth "1" ] []

