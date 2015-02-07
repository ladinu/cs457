-- Name of programmer: Ladinu Chandrasinghe
-- Email to send comments to: ladinu@gmail.com
module Drum where

import Music
import Text.ParserCombinators.Parsec
import Data.Text (pack, unpack, strip)

import Text.ParserCombinators.Parsec

-------------------------------------------------------------------------
{-
    I don't really know how Parsec works. But I followed the
    examples on http://book.realworldhaskell.org/read/using-parsec.html
    and adapted it to work with my own format
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
-------------------------------------------------------------------------

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

getTrackBeat (instr, [NoPlay]) = enr
getTrackBeat (instr, [Play])   = perc instr en []

getTrackBeat (instr, (NoPlay:xs)) = enr :+: getTrackBeat (instr, xs)
getTrackBeat (instr, (Play:xs))   = (perc instr en []) :+: getTrackBeat (instr, xs)

getDrumMusic [trk] = getTrackBeat trk
getDrumMusic (trk:trks) = (getTrackBeat trk) :=: (getDrumMusic trks)

machine0 = "BassDrum1     |x___|x___|x___|x___|x___|x___|x___|x___|\n\
       \   ElectricSnare  |____|____|____|____|____|____|____|____|\n\
       \   OpenHiHat      |__x_|__x_|__x_|__x_|__x_|__x_|__x_|__x_|\n\
       \   OpenHiHat      |____|____|____|____|____|____|____|____|\n\
       \   HandClap       |____|x___|____|x___|____|x___|____|x___|\n\
       \   Cowbell        |____|____|____|____|____|____|____|____|\n\
       \   CrashCymbal1   |____|____|____|____|____|____|____|____|\n"


getDrumMachineMusic = getDrumMusic . getDrumTracks . removeEmptyString . getList . parseDrumMachine

{-
    Given a ascii string which look like a drum machine, get the music it represent
    For example:
    drumMachineMusic rawText
-}
drumMachineMusic machine = Tempo 4 (Instr "Percussion" (getDrumMachineMusic machine))

