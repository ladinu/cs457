module Drum where

import Text.ParserCombinators.Parsec

import Music

eol :: GenParser Char st Char
eol = char '\n'

drumMachine :: GenParser Char st [[String]]
drumMachine =
    do result <- many track
       eof
       return result

track :: GenParser Char st [String]
track =
    do result <- beats
       eol
       return result

beats :: GenParser Char st [String]
beats =
    do first <- isMarked
       next  <- remainingBeats
       return (first : next)

remainingBeats :: GenParser Char st [String]
remainingBeats =
    (char '|' >> beats)
    <|> (return [])

isMarked :: GenParser Char st String
isMarked =
    many (noneOf "|\n")

parseDrumMachine :: String -> Either ParseError [[String]]
parseDrumMachine input = parse drumMachine "(unknown)" input


removeEmptyString xss = map (\x -> x) xss

