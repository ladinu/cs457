-- Name of programmer: Ladinu Chandrasinghe
-- Email to send comments to: Ladinu Chandrasinghe

{-

Prove:  map f x ++ map f y = map f (x ++ y)

-- Definitions and equations
1 map f [] = []
2 map f (x:xs) = (f x) : (map f xs)
3 (x:xs) ++ ys = x : (xs ++ ys)             <-- Induction Hypothesis
4 [] ++ xs = xs

-- Must Prove

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


-}
-- Definitions and equations
1 map f [] = []
2 map f (x:xs) = (f x) : (map f xs)
3 [] ++ x  = x
4 x ++ []  = x
5 [] ++ [] = []
