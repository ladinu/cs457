module Test where

-- (append xs ys) returns the lists xs and ys appended
-- For example:
--   append [1,2,3] [5,2] = [1,2,3,5,2]

append            :: [a] -> [a] -> [a]
append [] ys      = ys
append (x:xs) ys  = x : (append xs ys)

-- addup xs returns the sum of the numbers in
-- the list xs.  For example:
--   addup [1,2,3] = 6

addup            :: [Int] -> Int
addup []          = 0
addup (x:xs)      = x + (addup xs)

-- rev xs returns the list of values in xs in
-- reverse order.  For example:
--   rev [1,2,3] = [3,2,1]

rev       :: [Int] -> [Int]
rev []     = []
rev (x:xs) = (rev xs) ++ [x]

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

insert         :: Int -> [Int] -> [Int]
insert x []     = [x]
insert x (y:ys)
          | x > y = y : (insert x ys)
          | x <= y = x : y : ys

-- sort ns returns a sorted version of the list ns.
-- For example:
--   sort [1,2,3,4] = [1,2,3,4]
--   sort [4,3,2,1] = [1,2,3,4]
--   sort [3,1,4,2] = [1,2,3,4]
--   sort [3,2,3,1] = [1,2,3,3]
-- Hint: I suggest that you try to implement an
-- ***insert***ion sort :-)

sort       :: [Int] -> [Int]
sort []     = []
sort (n:ns) = insert n (sort ns)

-- splits ns returns the list of all triples (us, v, ws)
-- such that us ++ [v] ++ ws == ns.  For example:
--   splits [0,1,2] = [ ([], 0, [1,2]),
--                      ([0], 1, [2]),
--                      ([0,1], 2, []) ]

splits       :: [Int] -> [([Int], Int, [Int])]
splits [x]    = [ ( [], x, [])]
splits (x:xs) = ([], x, xs) : [ (x : us, v, ws) | (us, v, ws) <- splits xs ]

scheck  :: [Int] -> [([Int], Int, [Int])] -> Bool
scheck (n:ns) [(us, v, ws)] = (us ++ [v] ++ ws) == (n:ns)
scheck (n:ns) ((us, v, ws):xs) = ((us ++ [v] ++ ws) == (n:ns)) && (scheck (n:ns) xs)

data Bit = O | I deriving Show

type BinNum = [Bit]

toBinNum   :: Integer -> BinNum
fromBinNum :: BinNum -> Integer
inc        :: BinNum -> BinNum
add        :: BinNum -> BinNum -> BinNum
mul        :: BinNum -> BinNum -> BinNum
addr       :: BinNum -> BinNum -> BinNum
mulr       :: BinNum -> BinNum -> BinNum


toBinNum n | n==0 = [O]
           | even n = O : toBinNum(halfOfN)
           | odd  n = I : tail (toBinNum (n - 1))
             where halfOfN = n `div` 2

fromBinNum []     = 0
fromBinNum (O:ds) = 2 * fromBinNum ds
fromBinNum (I:ds) = 1 + (2 * fromBinNum ds)


inc [I] = [O, I]
inc (O:xs) = I : xs
inc (I:xs) = O : inc xs

add []     ds     = ds
add ds     []     = ds
add (O:ds) (e:es) = e : add ds es
add (I:ds) (O:es) = I : add ds es
add (I:ds) (I:es) = O : add (add [I] ds) es


mul [] ds         = []
mul ds []         = []
mul (O:ds) (e:es) = e : mul ds es
mul (I:ds) (O:es) = I : mul ds es
mul (I:ds) (I:es) = I : mul ds es


mulr x y = toBinNum (fromBinNum x * fromBinNum y)
addr x y = toBinNum (fromBinNum x + fromBinNum y)

testMul x y = fb (mulr (tb x) (tb y)) == fb (mul (tb x) (tb y))
    where
        tb = toBinNum
        fb = fromBinNum
        
testAdd x y = fb (addr (tb x) (tb y)) == fb (add (tb x) (tb y))
    where
        tb = toBinNum
        fb = fromBinNum
