-- Name of programmer: Ladinu Chandrasinghe
-- Email to send comments to: Ladinu Chandrasinghe

{-

Prove:  map f x ++ map f y = map f (x ++ y)

-- Definitions and equations
1 map f [] = []
2 map f (x:xs) = (f x) : (map f xs)

Prove

1) map f [] ++ map f [] = map f ([] ++ [])

2) map f [] ++ map f y = map f ([] ++ y)

3) map f x ++ map f [] = map f (x ++ [])

4)

4) map f bottom ++ map f bottom = map f (bottom ++ bottom)

5) map f bottom ++ map f y = map f (bottom ++ y)

6) map f x ++ map f bottom = map f (x ++ bottom)

-}
