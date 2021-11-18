main = print ()
myFst (x, _) = x -- FT-1
mySnd (_, x) = x -- FT-2
mySwap (x, y) = (y, x) -- FT-3

-- FT-4
distance2 (ax, ay) (bx, by) = sqrt ((ax-bx)^2 + (ay-by)^2)
distanceInf (ax, ay) (bx, by) = max (abs(ax-bx)) (abs(ay-by))

-- FT-6
myHead (h:_) = h
hasLengthTwo [_, _] = True
hasLengthTwo _ = False

-- FT-7
myLength [] = 0
myLength (_:t) = myLength t + 1

-- FT-8
myMinimum (h:t) = auxFunc t h
myMinimum [] = error "Empty list"
auxFunc [] m = m
auxFunc (h:t) m
    | h < m = auxFunc t h
    | otherwise = auxFunc t m

-- FT-9
{--
a ok
b ok
c ok
d ok 
e ok 
f error why? TODO:
g ok why? TODO:
h ok 
i ok why? TODO:
j ok 
k ok 
l ok 
--}

-- FT-10
f (_:_:x:y) = (x, y)
-- a) Given a list with 3 or more elements, removes the first 2.
fPrelude (h:t) = drop 2 (h:t)

-- FT-11
evaluateLengthA len
    | length len <= 1 = "Short"
    | length len <= 3 = "Medium-sized"
    | otherwise = "Long"
evaluateLengthB [] = "Short"
evaluateLengthB [_] = "Short"
evaluateLengthB [_,_] = "Medium-sized"
evaluateLengthB [_,_,_] = "Medium-sized"
evaluateLengthB _ = "Long"

-- FT-21 TODO:
{-
i)  zip [1,2] "abc" :: [(Integer, Char)]
    zip [1,2] "abc" :: Num a => [(a, Char)]
ii) [[1],[2]] :: [[Integer]]
    [[1],[2]] :: Num a => [[a]]
iii) [succ 'a'] :: [Char]
     [succ 'a'] :: [Char]
iv) [1,2,3,4,5.5] :: [Float]
    [1,2,3,4,5.5] :: Fractional a => [a]
v)  [1,2] == [1,2] :: Bool
    [1,2] == [1,2] :: Bool
vi) zip(zip"abc""abc")"abc" :: [((Char, Char), Char)]
    zip(zip"abc""abc")"abc" :: [((Char, Char), Char)]
-}

-- FT-23 TODO:
{-
a) mod :: Integral a => a -> a -> a
b) snd :: (a, b) -> b
c) [head, length] :: [[Int] -> Int]
d) drop :: Int -> [a] -> [a]
e) (!!) :: [a] -> Int -> a
f) zip :: [a] -> [b] -> [(a, b)]
-}

-- FT-24
f24 :: (a,b,a) -> (b,a,b)
f24 (a,b,_) = (b,a,b)