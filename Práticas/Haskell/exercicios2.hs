{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use replicate" #-}
{-# HLINT ignore "Use foldr" #-}
import Data.Char

-- 2.1
somaQuadrados n = sum[x^2 | x <- [1..n]]

-- 2.2. a)
aprox :: Int -> Double
aprox n = sum[(-1)^x / fromIntegral (2*x+1) | x <- [0..n]]

-- 2.2. b)
aprox' :: Int -> Double
aprox' n = sum[(-1)^k / fromIntegral (k+1)^2 | k <- [0..n]]

-- 2.3
dotprod :: [Float] -> [Float] -> Float
dotprod l1 l2 = sum[x*y | (x,y) <- zip l1 l2]

-- 2.4
divprop :: Integer -> [Integer]
divprop n = [x | x <- [1..n-1], mod n x == 0]

-- 2.5
perfeitos :: Integer -> [Integer]
perfeitos n = [x | x <- [1..n-1], sum (divprop x) == x]

-- 2.6
pitagoricos :: Integer -> [(Integer, Integer, Integer)]
pitagoricos n = [(x,y,z) | x <- [1..n], y <- [1..n], z <- [1..n], x^2 + y^2 == z^2]

-- 2.7
primo :: Integer -> Bool
primo n = divprop n == [1] -- divprop vê divisores até n-1, daí n precisar de n nesta lista

-- 2.8
binom :: Integer -> Integer -> Integer
binom n k = div (product [1..n]) (product [1..k] * product [1..(n-k)])

--pascal :: Integer -> [[Integer]]
--TODO:

-- 2.9
charToInt :: Char -> Int
charToInt c = ord c - ord 'A'

intToChar :: Int -> Char
intToChar n = chr (n + ord 'A')

desloca :: Int -> Char -> Char 
desloca k x
    | isUpper x = intToChar ((charToInt x + k) `mod` 26)
    | otherwise = x

cifra :: Int -> [Char] -> [Char]
cifra k s = [desloca k x | x <- s]

-- 2.10
myand :: [Bool] -> Bool
myand [] = True
myand [a] = a
myand l = head l && myand (tail l)

myor :: [Bool] -> Bool
myor [] = True
myor [a] = a
myor l = head l || myor (tail l)

myconcat :: [[a]] -> [a]
myconcat [] = []
myconcat l = head l ++ myconcat (tail l)

myreplicate :: Int -> a -> [a]
myreplicate n x = take n (repeat x)

myindex :: [a] -> Int -> a
myindex l n = l !! n

myelem :: Eq a => a -> [a] -> Bool
myelem a [] = False
myelem x (l:xs)
    | x == l = True
    | otherwise = myelem x xs

-- 2.11
myconcat' :: [[a]] -> [a]
myconcat' l = [x | xs <- l, x <- xs]

myreplicate' :: Int -> a -> [a]
myreplicate' n a = [a | _ <- [1..n]]

myindex' :: [a] -> Int -> a
myindex' l i = head ([x | x <- l, n <- [0..length l - 1], n == i])

-- 2.12
forte :: String -> Bool
forte x = length x >= 8 && 
            any isLower x &&
            any isUpper x &&
            any isNumber x

-- 2.13.a)
mindiv :: Int -> Int
mindiv 0 = 0
mindiv 1 = 1
mindiv n
    | null z = n
    | otherwise = head z
    where z = [ y | y <- [2..(floor . sqrt . fromIntegral) n], mod n y == 0]

-- 2.13.b)
primo' :: Int -> Bool
primo' n | n <= 1 = False
         | otherwise = mindiv n == n

-- 2.14
mynub :: Eq a => [a] -> [a]
mynub [] = []
mynub l = head l : mynub [x | x <- tail l, x /= head l]

-- 2.15
myintersperse :: a -> [a] -> [a]
myintersperse a [] = []
myintersperse a [l] = [l]
myintersperse a (x:xs) = [x, a] ++ myintersperse a xs

-- 2.16
algarismos, algarismosRev :: Int -> [Int]
algarismosRev 0 = []
algarismosRev l = mod l 10 : algarismosRev (div l 10)
algarismos l = reverse (algarismosRev l)

-- 2.17
toBits, toBitsRev :: Int -> [Int]
toBitsRev 0 = []
toBitsRev l = mod l 2 : toBitsRev (div l 2)
toBits l = reverse (toBitsRev l)

-- 2.18
fromBits, fromBitsAux :: [Int] -> Int 
fromBits l = fromBitsAux (reverse l)
fromBitsAux [] = 0
fromBitsAux (x:xs) = x + fromBitsAux ([a*2 | a <- xs])

-- 2.19
mdc :: Integer -> Integer -> Integer 
mdc a b
    | b == 0 = a
    | otherwise = mdc b (mod a b)

-- 2.20.a)
insert' :: Ord a => a -> [a] -> [a]
insert' x [] = [x]
insert' x (y:ys) = if x <= y then x:y:ys
                  else y : insert' x ys

-- 2.20.b)
--TODO:

-- 2.21.a)
myMinimum :: Ord a => [a] -> a
myMinimum l
    | length l == 1 = head l
    | otherwise = if head l < myMinimum (tail l) then head l else myMinimum (tail l)

-- 2.21.b)
myDelete :: Eq a => a -> [a] -> [a]
myDelete a [] = []
myDelete a l
    | head l == a = tail l
    | otherwise = head l : myDelete a (tail l)

-- 2.21.c)
ssort :: Ord a => [a] -> [a]
ssort [] = []
ssort l = myMinimum l : ssort (myDelete (myMinimum l) l)

-- 2.22.a)
myMerge :: Ord a => [a] -> [a] -> [a]
myMerge [] [] = []
myMerge [] l = l
myMerge l [] = l
myMerge l1 l2
    | head l1 < head l2 = head l1 : myMerge (tail l1) l2
    | otherwise = head l2 : myMerge l1 (tail l2)

-- 2.22.b)
metades :: [a] -> ([a],[a])
metades l = splitAt (div (length l) 2) l

msort :: Ord a => [a] -> [a]
msort [] = []
msort l
    | length l == 1 = [head l]
    | otherwise = myMerge (msort (fst (metades l))) (msort (snd (metades l)))

-- 2.23.a)
putListSameSize :: [Int] -> Int -> [Int]
putListSameSize l n | length l < n = putListSameSize (0:l) n
                    | otherwise = l
addPoly, addPolyAux :: [Int] -> [Int] -> [Int]
addPolyAux [] [] = []
addPolyAux l1 l2 = (head l1 + head l2) : addPoly (tail l1) (tail l2)
addPoly l1 l2 = addPolyAux (putListSameSize l1 (length l2)) (putListSameSize l2 (length l1))

-- 2.23.b)
multPoly :: [Int] -> [Int] -> [Int]
multPoly [0] _ = [0]
multPoly _ [0] = [0]
multPoly [] l = []
multPoly l [] = []
multPoly (x:xs) l2 = addPoly ([x * y | y <- l2]) (multPoly xs l2 ++ [0])