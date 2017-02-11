module Clock exposing (..)

import Html exposing (Html, div, text, program)
import Html.Attributes as HtmlAttr
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Time exposing (Time, second)
import Date
import Date.Format
import DigitalClock
import AnalogClock

main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


-- MODEL

type alias Model =
    Time


init : ( Model, Cmd Msg )
init =
    ( 0, Cmd.none )


-- UPDATE

type Msg
    = Tick Time


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick newTime ->
            ( newTime, Cmd.none )


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
    Time.every second Tick


-- VIEW
-- diff js: can't take time here, must be fed from 'event pipe' (note: clock in domotic backend drives everything)

view : Model -> Html Msg
view model =
    div [] [
        AnalogClock.view model,
        DigitalClock.view model
    ]
