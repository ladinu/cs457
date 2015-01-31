module Drum where

import Text.ParserCombinators.Parsec

import Music

main =
  do { writeMidi cScale "Music/cScale"
     }


cScale =
  line [c 4 qn [], d 4 qn [], e 4 qn [],
        f 4 qn [], g 4 qn [], a 4 qn [],
        b 4 qn [], c 5 qn []]

