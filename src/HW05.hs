-- Name of programmer: Ladinu Chandrasinghe
-- Email to send comments to: Ladinu Chandrasinghe

{-

Prove:  map f x ++ map f y = map f (x ++ y)

-- Definitions and equations
1 map f [] = []
2 map f (x:xs) = (f x) : (map f xs)
3 [] ++ x  = x
4 x ++ []  = x
5 [] ++ [] = []

-- Must Prove

1) map f [] ++ map f [] = map f ([] ++ [])

2) map f [] ++ map f y = map f ([] ++ y)

3) map f x ++ map f [] = map f (x ++ [])

4) Assuming:    map f qs ++ map f vs = map f (qs ++ vs)
   Prove:       map f (q:qs) ++ map f (v:vs) = map f ((q:qs) ++ (v:vs))

5) map f bottom ++ map f bottom = map f (bottom ++ bottom)

6) map f bottom ++ map f y = map f (bottom ++ y)

7) map f x ++ map f bottom = map f (x ++ bottom)

-- Proof
1) map f [] ++ map f [] = map f ([] ++ [])

   map f [] ++ map f [] = map f []        -->   (By 5)
   map f [] ++ map f [] = []              -->   (By 1)
   [] ++ [] = []                          -->   (By using 1 twice)
   [] = []                                -->   (By 5)

2)

-}
