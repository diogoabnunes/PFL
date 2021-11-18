main = print()

-- 2.1
squareSum n = sum[n^2 | n <- [1..n]]

-- 2.2. a)
aprox1 :: Int -> Double
aprox1 n = sum[(-1)^x / fromIntegral (2*x+1) | x <- [0..n]]

-- 2.2. b)
aprox2 :: Int -> Double
aprox2 n = sum[(-1)^k / fromIntegral (k+1)^2 | k <- [0..n]]

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
pitagoricos n = [(x,y,z) | x<-[1..n], y<-[1..n], z<-[1..n], x^2+y^2 == z^2]

-- 2.7
primo :: Integer -> Bool
primo n = divprop n == [1] -- divprop is defined until n-1, that's why

-- 2.8
binom :: Integer -> Integer -> Integer
binom n k = div (product [1..n]) (product [1..k] * product [1..(n-k)])

--pascal :: Integer -> [[Integer]]

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
-- 2.16
algarismos :: Int -> [Int]
algarismosRev :: Int -> [Int]
algarismosRev 0 = []
algarismosRev l = mod l 10 : algarismosRev (div l 10)
algarismos l = reverse (algarismosRev l)
-- 2.17
toBits :: Int -> [Int]
toBitsRev :: Int -> [Int]
toBitsRev 0 = []
toBitsRev l = mod l 2 : toBitsRev (div l 2)
toBits l = reverse (toBitsRev l)
-- 2.19
mdc :: Integer -> Integer -> Integer 
mdc a b
    | b == 0 = a
    | otherwise = mdc b (mod a b)
-- 2.20
--a
insert :: Ord a => a -> [a] -> [a]
insert x [] = [x]
insert x (y:ys) = if x <= y then x:y:ys
                  else y : insert x ys
--b
isort :: Ord a => [a] -> [a]
isort [] = []
isort (x:xs) = insert x (isort xs)