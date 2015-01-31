module Drum where

import Data.Text (pack, unpack, strip)
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

-- Given a name of Percussion sound, return the haskore Percussion
-- sound type
getPercussionSound string           = _getPercussionSound (stripSpaces string)
_getPercussionSound "BassDrum1"     = BassDrum1
_getPercussionSound "ElectricSnare" = ElectricSnare
_getPercussionSound "ClosedHiHat"   = ClosedHiHat
_getPercussionSound "OpenHiHat"     = OpenHiHat
_getPercussionSound "HandClap"      = HandClap
_getPercussionSound "HighTom"       = HighTom
_getPercussionSound "CrashCymbal1"  = CrashCymbal1
_getPercussionSound "Cowbell"       = Cowbell

data DrumBeat  = Play | NoPlay deriving Show
type DrumTrack = (PercussionSound, [DrumBeat])
type DrumMusic = [DrumTrack]

getList (Right x) = x
stripSpaces str = unpack (strip (pack str))
removeEmptyString = map (\x -> (filter (/="") x))

getBeat '_' = NoPlay
getBeat 'x' = Play
getBeats xss  = map getBeat (concat xss)

getDrumTrack row = (getPercussionSound (head row), getBeats (tail row))
getDrumTracks = map getDrumTrack


rawText = "BassDrum1      |x_x_|____|x___|x___|x___|____|x___|____|\n\
       \   ElectricSnare  |____|____|____|____|____|____|____|____|\n\
       \   ClosedHiHat    |____|xxx_|____|_xxx|__x_|____|____|____|\n\
       \   OpenHiHat      |____|____|____|____|____|____|____|x___|\n\
       \   HandClap       |____|____|____|____|____|____|____|____|\n\
       \   Cowbell        |____|____|xx__|____|____|__xx|____|___x|\n\
       \   HighTom        |____|____|____|____|____|____|____|__x_|\n\
       \   CrashCymbal1   |____|____|____|____|____|____|____|____|\n"

pp = getDrumTracks . removeEmptyString . getList . parseDrumMachine