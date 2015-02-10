-- Name of programmer: Ladinu Chandrasinghe
-- Email to send comments to: Ladinu Chandrasinghe

{-

Prove:  map f x ++ map f y = map f (x ++ y)

-- Definitions and equations
1 map f [] = []
2 map f (x:xs) = (f x) : (map f xs)
3 (x:xs) ++ ys = x : (xs ++ ys)             <-- Induction Hypothesis
4 [] ++ xs = xs

-- Must prove following cases
1) map f [] ++ map f y = map f ([] ++ y)

2) Assuming:    map f ps ++ map f y = map f (ps ++ y)
   Prove:       map f (p:ps) ++ map f y = map f ((p:ps) ++ y)

3) map f bottom ++ map f y = map f (bottom ++ y)

-- Proof
1) map f [] ++ map f y = map f ([] ++ y)

   map f [] ++ map f y = map f y          -->   (By 4)
   [] ++ map f y = map f y                -->   (By 1)
   map f y = map f y                      -->   (By 4)

2) Assuming:    map f ps ++ map f y = map f (ps ++ y)
   Prove:       map f (p:ps) ++ map f y = map f ((p:ps) ++ y)

   (f p) : (map f ps) ++ map f y = map f ((p:ps) ++ y)      -->   (By 2)
   (f p) : (map f ps ++ map f y) = map f ((p:ps) ++ y)      -->   (By 3)
   map f (p : (ps ++ y)) = map f ((p:ps) ++ y)              -->   (By 2 using backwards substitution)
   map f ((p:ps) ++ y)) = map f ((p:ps) ++ y)               -->   (By 3 using backwards substitution)

3) map f bottom ++ map f y = map f (bottom ++ y)

   bottom ++ map f y = map f bottom    -->   (By pattern matching and strictness of map)
   bottom = bottom                     -->   (By pattern matching)



Prove:  length . reverse = length

-- Definitions and equations
5 (f . g) x = f(g x)
6 length (x:xs) = 1 + length xs
7 reverse [] = []
8 reverse (x:xs) = reverse xs ++ [x]
9 lenghth [] = 0
10 [] ++ xs = xs
L1 length (xs ++ ys) = length xs + length ys         <-- TODO: prove this lemma

-- Must prove following cases
E(x) = (length . reverse) x = length x

1) E([])                    (length . reverse) []       = length []

2) Assuming:     E(zs)      (length . reverse) zs       = length zs
   Prove:        E(z:zs)    (length . reverse) (z:zs)   = length (z:zs)

3) E(bottom)                (length . reverse) bottom   = length bottom

-- Proof
1) (length . reverse) [] = length []

   length (reverse []) = length []      -->     (By 5)
   length [] = length []                -->     (By 7)

2) Assuming:     (length . reverse) zs       = length zs
   Prove:        (length . reverse) (z:zs)   = length (z:zs)

   length (reverse (z:zs)) = length (z:zs)             -->     (By 5)
   length (revese zs ++ [z]) = length (z:zs)           -->     (By 8)
   length (revese zs) + length [z] = length (z:zs)     -->     (By L1)

3) (length . reverse) bottom = length bottom

   length (reverse bottom) = length bottom     -->     (By 5)
   length bottom = length bottom               -->     (By patternmatching and strictness of reverse)

-- Lemma L1

length (xs ++ ys) = length xs + length ys


-- Must prove following cases
1) length ([] ++ ys) = length [] + length ys
2) length ((x:xs) ++ ys) = length (x:xs) + length ys
3) length (bottom ++ ys) = length bottom + length ys


-- Proof

1) length ([] ++ ys) = length [] + length ys

   length ys = [] + length ys       -->     (By 10)
   length ys = 0 + length ys        -->     (By 9)
   length ys = length ys            -->     (By math)

2) length ((x:xs) ++ ys) = length (x:xs) + length ys

   length ( x : (xs ++ ys)) = length (x:xs) + length ys    -->     (By 3)
   1 + length (xs ++ ys) = length (x:xs) + length ys       -->     (By 6)
   1 + (length xs + length ys) = length (x:xs) + length ys -->     (By induction hypothesis)
   1 + (length xs) + length ys = length (x:xs) + length ys -->     (By associativity of +)
   length (x:xs) + length ys = length (x:xs) + length ys   -->     (By 6 backwards)
   
3) length (bottom ++ ys) = length bottom + length ys
-}
