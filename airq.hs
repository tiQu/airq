#!/usr/bin/env cabal
{- cabal:
build-depends: base, aeson, text, bytestring, network-uri, http-client, http-client-tls
-}

{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}

import qualified Network.HTTP.Client            as H
import qualified Network.HTTP.Client.TLS        as H
import Network.URI (escapeURIString)
import GHC.Generics
import Data.Aeson
import Data.Text
import Control.Applicative
import qualified Data.ByteString.Lazy as B

data AreaCode = AreaCode { areacode :: String } deriving (Show, Generic)
instance FromJSON AreaCode where
  parseJSON (Object v) = AreaCode
                         <$> (v .: "areacode")

-- tQ: TODO define main function, use map function list to apply over API results, return and render result

main :: IO ()
main = do
  inputFile <- B.readFile "areacode.json"
  let ma = decode inputFile :: Maybe AreaCode

  case ma of
    Nothing -> print "Error parsing local JSON file"
    Just a  -> queryAirQuality a

queryAirQuality :: AreaCode -> IO ()
queryAirQuality a = print ((show.areacode) a)
  --do
  {-
  httpman <- H.newManager H.tlsManagerSettings
  --localFile.location
  let encodedQueryString = H.parseRequest ("https://api.weather.gc.ca/collections/aqhi-forecasts-realtime/items/AQ_FCST-" ++ a.areacode ++ "-202309030000-202309030000?f=json")
  let req = H.setQueryString [("q", Just "r")] encodedQueryString
  response <- H.httpLbs req httpman
  print response-}
