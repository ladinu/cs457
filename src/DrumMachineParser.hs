module DrumMachineParser (parseDrumMachine) where

import Text.ParserCombinators.Parsec

{-
    I don't really know how Parsec works. But I followed the
    examples on http://book.realworldhaskell.org/read/using-parsec.html
    and adapted it to work with my raw text format
-}
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
