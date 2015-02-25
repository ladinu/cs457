-----------------------------------------------------------------------
CS457/557 Functional Languages                Type Classes (Homework 6)
-----------------------------------------------------------------------
Name of programmer: Ladinu Chandrasinghe
Email to send comments to: ladinu@gmail.com

Consider the following class definition, which is designed to
characterize the set of types that contain only finitely many
distinct elements:

> import Prelude hiding (maxBound, minBound)
> class Finite a where
>   elements :: [a]
>   maxBound :: a
>   minBound :: a

For example, we can certainly enumerate the set of all Bool
values, so we might declare the following instance:

> instance Finite Bool where
>   elements = [ False, True ]
>   maxBound = last elements
>   minBound = head elements

We can repeat this same idea for other enumerated types:

> data Day     = Sun | Mon | Tue | Wed | Thu | Fri | Sat deriving (Show, Eq)
> data Month   = Jan | Feb | Mar | Apr | May | Jun
>              | Jul | Aug | Sep | Oct | Nov | Dec deriving (Show, Eq)
> data Rainbow = Red | Orange | Yellow | Green | Blue | Indigo | Violet deriving (Show, Eq)

Of course, all of these types are finite:

> instance Finite Day where
>   elements = [Sun, Mon, Tue, Wed, Thu, Fri, Sat]
>   maxBound = last elements
>   minBound = head elements

> instance Finite Month where
>   elements = [ Jan, Feb, Mar, Apr, May, Jun,
>                Jul, Aug, Sep, Oct, Nov, Dec]
>   maxBound = last elements
>   minBound = head elements

> instance Finite Rainbow where
>   elements = [Red, Orange, Yellow, Green, Blue, Indigo, Violet]
>   maxBound = last elements
>   minBound = head elements


As a slightly more interesting example, consider the Maybe datatype
that is defined in the prelude as follows:

  data Maybe a = Nothing | Just a

If we can enumerate the elements of some type t, then we can also
enumerate all the elements of Maybe t, as the following instance
describes:

> instance Finite a => Finite (Maybe a) where
>   elements = [ Nothing ] ++ [ Just x | x <- elements ]
>   maxBound = last elements
>   minBound = head elements

A critical property that we would like to hold for each instance t of
Finite is that any element x of type t will appear in the corresponding
list elements :: [t].  For types t that are also in the Eq class, we
might try to capture this with a QuickCheck property like the following:

> prop_AllElementsAppear n  =  n `elem` elements

Note that this law is stated in a very general form; if you try to run
quickCheck prop_AllElementsAppear directly, then you will get an error
message because QuickCheck won't know which element type to use.  You
will therefore need to find a way to insert type information into your
tests, as in: quickCheck (prop_AllElementsAppear :: Bool -> Bool).

(Also note: For the purposes of this exercise: if you know about the
possibility of types that include a bottom element---representing an
error or nontermination, for example---then you should ignore those
cases here ... which, of course, is also what you would have done if you
haven't heard about this issue ...)

Now here are the questions:

1) Define instances of Finite for the Int type (whose minimum and
maximum values can be obtained as (minBound::Int) and (maxBound::Int),
respectively), the product type (a, b) (assuming, of course that both
a and b are finite), and the sum type Either a b, which is defined in
the prelude as:

   data Either a b = Left a | Right b

Explain how your definitions work and use QuickCheck to verify that
your definitions satisfy the proposed law, at least on the basis of
some random tests.  [Note that a finite type can still have many
elements; you might want to think carefully about how you write your
instance definitions, especially the one for Int, to ensure that
testing does not take too long!]

> instance Finite Int where
>   elements = [0, 1 .. 100]
>   maxBound = last elements
>   minBound = head elements

> instance (Finite a, Finite b) => Finite (a, b) where
>   elements = [ (x, y) | x <- elements, y <- elements]
>   maxBound = last elements
>   minBound = head elements

> instance Finite (Either a b) where
>   elements = [x | Left x <- elements ] ++ [y | Right y <- elements]
>   maxBound = last elements
>   minBound = head elements

2) If a is a Finite type, then we can use elements :: [a] to obtain
the list of all values in the domain of a function of type a -> b.
Use this observation to define the following instances for displaying
functions (you may use whatever notation you prefer) and for testing
functions for equality:

  instance (Finite a, Show a, Show b) => Show (a -> b) where
    show f = ...

  instance (Finite a, Eq b) => Eq (a -> b) where
    f == g  =  ...

You may, of course, define any auxiliary functions that you need to
make these definitions work as you would expect.

3) Devise an algorithm for calculating a list of all functions of type
a -> b for any finite types a and b.  Show that this can be wrapped
up as an instance of the Finite type class:

  instance (Eq a, Finite a, Finite b) => Finite (a -> b) where
    ...

Again, use QuickCheck to verify that your definition satisfies the law
specified in the introduction.

4) Suppose that we want to be able to calculate the number of elements
in any given finite type.  This can be accomplished by adding the
following lines to the end of the definition of the Finite class:

   size  :: a -> Integer
   size x = length (x:elements) - 1

Explain why the definition was written in this (rather odd) manner
instead of just writing:

   size  :: Integer
   size   = length elements

(If you're not sure why this wouldn't work, maybe you should enter it
into your code and see what happens ...)

Show that you can obtain considerably more efficient definitions for
size by overriding the implementation of size in specific instances of
the Finite class.

5) Use QuickCheck to formulate and test some properties about size for
Maybe types, product types (pairs), and sum types (Either).  For
example, if the finite type t has n elements, then how many elements
would you expect to find in the type Maybe t?  How useful is QuickCheck
in cases like this?

------------------------------------------------------------------------
