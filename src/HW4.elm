module HW4 exposing (..)
import List as L
import Date exposing(..)
import Json.Decode as J
import Json.Decode.Pipeline exposing (required, optional, hardcoded)

type alias User =
    { name : String
    , cats : Maybe Int
    }

decodeUser : J.Decoder User
decodeUser =
    J.map2
        (\name cats -> { name = name, cats = cats })
        (J.field "name" J.string)
        (J.field "cats" (J.maybe J.int))

-- Mottos
mottos : String
mottos =
    """
      {"Germany": {"motto": "Einigkeit und Recht und Freiheit", "currency": "EUR"},
       "England": {"motto": "God Save the Queen", "currency": "GBP"},
       "France": {"motto": "Liberté, Égalité, Fraternité", "currency": "EUR"}}
      """

type alias Mottos =
    { countries : List Country }

type alias Country =
    { name : String
    , motto : String
    , currency : String
    }

type alias CountryData =
    { motto : String
    , currency : String
    }

decodeCountryData : J.Decoder CountryData
decodeCountryData =
    J.map2
        (\motto currency -> { motto = motto, currency = currency })
        (J.field "motto" J.string)
        (J.field "currency" J.string)

decodeCountry : J.Decoder (List ( String, CountryData ))
decodeCountry = J.keyValuePairs decodeCountryData

-- J.map : (a -> value) -> Decoder a -> Decoder value
-- XXX: hell!
decodeMottos : J.Decoder Mottos
decodeMottos =
    J.map
        (\li -> { countries = L.map (\(cn,cd) -> { name    = cn,
                                                   motto   = cd.motto,
                                                   currency= cd.currency}) li })
        decodeCountry

-- Date decoder
decodeDate : J.Decoder Date
decodeDate =
    let
        convert : String -> J.Decoder Date
        convert raw =
            case Date.fromIsoString raw of
                Ok date ->
                    J.succeed date

                Err error ->
                    J.fail error
    in
        J.string |> J.andThen convert


-- Account info
type alias AccountInfo  =
   { id: Int
   , email: String
   , full_name: (Maybe String)
   , phone_number: (Maybe String)
   , info_complete: Bool
   }

jsonDecAccountInfo : J.Decoder AccountInfo
jsonDecAccountInfo =
    J.succeed AccountInfo
        |> required "id"            J.int
        |> required "email"         J.string
        |> required "full_name"     (J.nullable J.string)
        |> required "phone_number"  (J.nullable J.string)
        |> required "info_complete" J.bool

accInfo : String
accInfo =
    """
     {"id": 1, "email": "bb@u.net", "full_name": "A", "phone_number": "555",
     "info_complete": true}
    """
