----------------------------------------------------------------------
CS457/557 Functional Languages                              Homework 2
----------------------------------------------------------------------

Name of programmer: Ladinu Chandrasinghe
Email to send comments to: ladinu@gmail.com


Due at the start of class on January 19.  You are welcome to work on this
assignment on your own, or with a partner.  In the latter case, turn in
only one copy, but be sure that your submission is clearly labeled with
the names of both partners.

You are welcome (indeed, encouraged!) to use GHCi for help with
all of these questions, but try to predict what the the answers will be
before you try them on the computer ...

Question 1: 
(10 points)
-----------
Give possible types for each of the following expressions (or else
explain why you think the expression is ill-typed):
 a) map odd
 map odd :: (Integer a) => [a] -> [Bool]

 b) takeWhile null
 This is ill-typed because takeWhile takes a function that map anything into a Bool.
 But null function maps a list of anything into a boolean. The type of null function is
 [a] -> Bool. Hence, null function does not have a compatible type for takeWhile function.import

 c) (++[])
 (++[]) :: [a] -> [a]

 d) (:[])
 (:[]) :: a -> [a]

 e) ([]:)
 (:) :: a -> [a] -> [a]. And [] :: [t]. Thus ([]:) :: [[t]] -> [[t]]

 f) [ [], [[]], [[[]]], [[[[]]]], [[[[[True]]]]] ]
 Above expression has type [[[[[[Bool]]]]]]

 g) [ [True], [[]], [[[]]], [[[[]]]], [[[[[]]]]] ]
 This is ill-typed because the type of above expression should be
 a list that contain list of bools. Only one element of the above
 list satisfy the type list of list of bools.

 h) map map
 map map :: [a -> b] -> [[a] -> [b]]

 i) map (map odd)
 map (map odd) :: Integral a => [[a]] -> [[Bool]]

 j) map . map
 map . map :: (a -> b) -> [[a] -> [b]]

 k) (map , map)
 (map, map) :: ((a -> b) -> [a] -> [b], (a1 -> b1) -> [a1] -> [b1])



Question 2:
(10 points)
-----------
Explain what each of the following functions does:
 a) odd . (1+)
 The above expresion is a function that takes an integer i, add 1
 to i and see if the resulting integer is odd

 b) odd . (2*)
 This is a function that always return False. By definition 2*n is always
 even. So the above function cannot return True.

 c) ([1..]!!)
 When given an index, the above function return effectively index + 1.
 The !! return the element in the infinite list which start from 1.
 Hence ([1..]!!) 0 = 1. For indexes that are negative, it causes an
 exception.

 d) (!!0)
 The function always return the first element of a list. If the list
 is empty, it return an exception.

 e) reverse . reverse
 Given a list to the above function, it simply returns the original list

 f) reverse . tail . reverse
 Given a list the above function returns the same list without the last
 element. It should invoke an exception if called on the empty list
 because ther is no tail of an empty list.

 g) map reverse . reverse . map reverse
 The function reverse a list of lists.

 
Question 3:
(60 points)
-----------
Complete the following definitions of functions on lists
by deleting or replacing the portions marked with "..."
in each case.  These are intended to be simple, recursive
function definitions; you can find analogs for most of
these functions in the standard Haskell prelude and libraries,
but you should not use those functions here!  Do not worry
about "efficiency", but be sure to run some tests to confirm
that your definitions work as intended.

-- (append xs ys) returns the lists xs and ys appended
-- For example:
--   append [1,2,3] [5,2] = [1,2,3,5,2]

> append            :: [a] -> [a] -> [a]
> append [] ys      = ys
> append (x:xs) ys  = x : (append xs ys)

-- addup xs returns the sum of the numbers in
-- the list xs.  For example:
--   addup [1,2,3] = 6

> addup            :: [Int] -> Int
> addup []          = 0
> addup (x:xs)      = x + (addup xs)

-- rev xs returns the list of values in xs in
-- reverse order.  For example:
--   rev [1,2,3] = [3,2,1]

> rev       :: [Int] -> [Int]
> rev []     = []
> rev (x:xs) = (rev xs) ++ [x]

-- insert n ns inserts the integer n into the list
-- of integers ns.  You can assume that the numbers
-- in the list ns are already arranged in ascending
-- order.  For example:
--   insert 3 [1,2,4,5] = [1,2,3,4,5]
--   insert 5 [1,2,3,4] = [1,2,3,4,5]
--   insert 0 [1,2,3,4] = [0,1,2,3,4]
--   insert 2 [1,2,3,4] = [1,2,2,3,4]
-- As this last example shows, insert does not attempt
-- to eliminate duplicate elements from the list.

> insert         :: Int -> [Int] -> [Int]
> insert x []     = [x]
> insert x (y:ys)
>           | x > y = y : (insert x ys)
>           | x <= y = x : y : ys

-- sort ns returns a sorted version of the list ns.
-- For example:
--   sort [1,2,3,4] = [1,2,3,4]
--   sort [4,3,2,1] = [1,2,3,4]
--   sort [3,1,4,2] = [1,2,3,4]
--   sort [3,2,3,1] = [1,2,3,3]
-- Hint: I suggest that you try to implement an
-- ***insert***ion sort :-)

> sort       :: [Int] -> [Int]
> sort []     = ...
> sort (n:ns) = ... (sort ns) ...

-- splits ns returns the list of all triples (us, v, ws)
-- such that us ++ [v] ++ ws == ns.  For example:
--   splits [0,1,2] = [ ([], 0, [1,2]),
--                      ([0], 1, [2]),
--                      ([0,1], 2, []) ]

> splits       :: [Int] -> [([Int], Int, [Int])]
> splits [x]    = [ ([], x, []) ]
> splits (x:xs) = ([], x, xs) : [ (x : us, v, ws) | (us, v, ws) <- splits xs ]


Question 4:
(20 points)
-----------
Suppose that n :: Int; explaining how you arrive at your answer,
explain what result you will get from the following expression.

  sum [ x - y | x <- [1..n], y <- [1..n] ]

  The above expression is essentially the following pseudocode.

  ret = []
  for (x = 1.. n) {
    for (y = 1..n) {
      ret.append(x - y)
    }
  }
  sum ret

  The list contain numbers from 0..n and each number has a corresponding
  negative number. So when you compute sum of the list, each number
  cancel each other and is left with 0. Essentially the above function
  compute 0.

Verify your answer by evaluating this expression for some specific
values of n.


----------------------------------------------------------------------
