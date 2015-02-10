module TestingExerciseSkeleton where

import Test.HUnit  -- (Test(TestCase,TestList),assertEqual,runTestTT)
import Test.QuickCheck


addOne :: [Int] -> [Int]

addOne [] = []
addOne (x:xs) = (1 + x) : addOne xs

t0 = TestCase (assertEqual "addOne []" (addOne []) [])
t1 = TestCase (assertEqual "addOne [1]" (addOne [1]) [2])
t2 = TestCase (assertEqual "addOne [-1]" (addOne [-1]) [0])
tests = TestList [t0, t1, t2]

addN:: Int -> [Int] -> [Int]
addN n [] = []
addN n (x:xs) = (n + x) : addN n xs

addNT0 = TestCase (assertEqual "addN 0 []" (addN 0 []) [])
addNT1 = TestCase (assertEqual "addN 0 [1]" (addN 0 [1]) [1])

addNTests = TestList [addNT0, addNT1]

prefixSums:: [Int] -> [Int]
prefixSums = undefined

takE:: Int -> [a] -> [a]
takE = undefined