module Music(module Haskore, play) where

import Haskore
import System.Process(system)
import System.Directory(getCurrentDirectory)
import Data.Ratio((%))

----------------------------------------------------------
-- commands for creating and playing music 


-- Here attempt to script the playing of music
-- Source location of the windows media player
player = "fluidsynth"

-- the appropriate command line flag
command = " -i /usr/local/share/fluidsynth/GeneralUser\\ GS\\ 1.44\\ FluidSynth/GeneralUser\\ GS\\ FluidSynth\\ v1.44.sf2 "

play file  = do
    system (player ++ command ++ "/Users/ladinu/School/cs457/src/Music/" ++ file)
    return ()

