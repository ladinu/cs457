module Music(module Haskore, play, writeMidi, (%)) where

import Haskore
import System.Process(system)
import System.Directory(getCurrentDirectory)
import Data.Ratio((%))

----------------------------------------------------------
musicPath = "/Users/ladinu/School/cs457/src/Music/"

-- write music "m" to "file.mid"
-- this file "test.mid" can be double clicked to play
writeMidi m file = outputMidiFile (musicPath ++ file++".mid") (testMidi m)

-- Here attempt to script the playing of music
-- Source location of the windows media player
player = "fluidsynth"

-- the appropriate command line flag
command = " -i /usr/local/share/fluidsynth/GeneralUser\\ GS\\ 1.44\\ FluidSynth/GeneralUser\\ GS\\ FluidSynth\\ v1.44.sf2 "

play m  = do
    writeMidi m "out"
    system (player ++ command ++ musicPath ++ "out.mid")
    return ()

