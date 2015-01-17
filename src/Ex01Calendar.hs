module Ex01Calendar where

import Excell

-- Name of programmer: Ladinu Chandrasinghe
-- Email to send comments to: ladinu@gmail.com

{-
1) Got to the programming resource links. Find the libraries.
   Right click on "Excell.hs" and save it in the same 
   directory where you saved this file.
   
2) While you're there also right-click and download
   the "CSV.hs" library and save it in the same 
   directory where you saved this file.
   
3) Write a program that creates an Excel table that looks 
   like a calendar for April 2009.
   
4) Due Tuesday Jan 15.   

+---+---+---+---+---+---+---+
|A  |P  |R  |I  |L  |   |   |
+---+---+---+---+---+---+---+
|Sun|Mon|Tue|Wed|Thu|Fri|Sat|
+---+---+---+---+---+---+---+
|   |   |   |1  |2  |3  |4  |
+---+---+---+---+---+---+---+
|5  |6  |7  |8  |9  |10 |11 |
+---+---+---+---+---+---+---+
|12 |13 |14 |15 |16 |17 |18 |
+---+---+---+---+---+---+---+
|19 |20 |21 |22 |23 |24 |25 |
+---+---+---+---+---+---+---+
|26 |27 |28 |29 |30 |   |   |
+---+---+---+---+---+---+---+   

-}   



-- Each row of the table corresponds to a list.

month:: [ Char]
days:: [String]
week1,week2,week3,week4,week5:: [Integer]


-- Create naming declarations for each row with
-- the type designated above

month = "APRIL  "

days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]

week1 = leftAlign [1..4]
week2 = [5..11]
week3 = [12..18]
week4 = [19..25]
week5 = [26..30]

weeks = [week1, week2, week3, week4, week5]

-- Use the Excel functions
-- row, col, rows, cols, blankRow, blankCol, beside, above
-- to create a calendar table.

leftAlign    r = [0] ++ r
leftAligned  r = head r == 0
blanks       r = blankRow (length days - length (removeZero r))
removeZero   r = filter (/= 0) r

alignedRow r
           | leftAligned  r  = blanks r `beside` row (removeZero r)
           | otherwise = row r

header   = row month `above` row days
calendar =  header `above` stack (map alignedRow weeks)

-- Extra credit, create calendars for other months
