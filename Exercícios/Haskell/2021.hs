{- 1.
a) [4,3,2,1]
b) [4,7,10]
c) [(1,4),(2,2)]
d) (3,'c')
e) foldr (-) 0 [1,2,3]
f) [(Int,[Int])]
g) (Eq a, Num a) => [a] -> [a]
h) (a -> Bool) -> [a] -> [a]
-}

-- 2.a)
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
divisores :: Integer -> [Integer]
divisores n = [x | x <- [1..n-1], mod n x == 0]

primo :: Integer -> Bool
primo n = divisores n == [1]

-- 2.b)
gemeos :: Integer -> (Integer, Integer)
gemeos n = head [(x,x+2) | x <- [n..n^2], primo x, primo (x+2)]

-- 3
type Point = (Double, Double)

getMinX, getMinY, getMaxX, getMaxY :: [Point] -> Double
getMinX [] = 0
getMinX [(x,y)] = x
getMinX (x:y:ys) = if fst x < fst y then getMinX (x:ys) else getMinX (y:ys)
getMinY [] = 0
getMinY [(x,y)] = y
getMinY (x:y:ys) = if snd x < snd y then getMinY (x:ys) else getMinY (y:ys)
getMaxX [] = 0
getMaxX [(x,y)] = x
getMaxX (x:y:ys) = if fst x > fst y then getMaxX (x:ys) else getMaxX (y:ys)
getMaxY [] = 0
getMaxY [(x,y)] = y
getMaxY (x:y:ys) = if snd x > snd y then getMaxY (x:ys) else getMaxY (y:ys)

boundingBox :: [Point] -> (Point, Point)
boundingBox l = ((getMinX l, getMinY l), (getMaxX l, getMaxY l))

-- 4
data Set a = Empty | Node a (Set a) (Set a) deriving(Show)

-- a)
insert :: Ord a => a -> Set a -> Set a
insert e Empty = Node e Empty Empty
insert e (Node n Empty Empty)
    | e < n = Node n (Node e Empty Empty) Empty
    | e > n = Node n Empty (Node e Empty Empty)
    | otherwise = Node n Empty Empty
insert e (Node n esq Empty)
    | e < n = Node n (insert e esq) Empty
    | e > n = Node n esq (Node e Empty Empty)
    | otherwise = Node n esq Empty
insert e (Node n Empty dir)
    | e < n = Node n (Node e Empty Empty) dir
    | e > n = Node n Empty (insert e dir)
    | otherwise = Node n Empty dir
insert e (Node n esq dir)
    | e < n = Node n (insert e esq) dir
    | e > n = Node n esq (insert e dir)
    | otherwise = Node n esq dir

-- b)
exists :: (a -> Bool) -> Set a -> Bool
exists f Empty = False 
exists f (Node n Empty Empty) = f n 
exists f (Node n esq dir) = f n || exists f esq || exists f dir 