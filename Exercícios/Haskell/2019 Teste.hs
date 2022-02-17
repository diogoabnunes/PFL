{- 1.
a) [[1,2],[],[3,4],[5]]
b) [5]
c) 2
d) [16,20,24,28,32]
e) [(3,2),(4,3),(5,4),(5,6),(6,8),(7,12)]
f) [[2,8],[4,6],[]]
g) [(x,y) | (x,y) <- zip [0..6] [6,5..]]
h) 3+3+5+0+0+4 = 15
i) [(Char,String)]
j) (Num a, Ord a) => a -> [a] -> Bool
k) Eq a => [a] -> Bool
l) Eq a => (a -> a) -> a -> Bool 
-}

-- 2
pitagoricos :: Int -> Int -> Int -> Bool
pitagoricos a b c = a^2 + b^2 == c^2 || a^2 + c^2 == b^2 || b^2 + c^2 == a^2

hipotenusa :: Float -> Float -> Float
hipotenusa a b = sqrt (a^2 + b^2)

-- 3
diferentes1, diferentes2 :: Eq a => [a] -> [a]

diferentes1 [] = []
diferentes1 [x] = []
diferentes1 (x:y:ys) = if x == y then diferentes1 (y:ys) else x:diferentes1 (y:ys)

diferentes2 l = [x | (x,y) <- zip l (tail l), x /= y]

-- 4
zip3' :: [a] -> [b] -> [c] -> [(a,b,c)]
zip3' l1 l2 l3 = [(x,y,z) | (x,(y,z)) <- zip l1 (zip l2 l3)]

-- 5
partir :: Eq a => a -> [a] -> ([a],[a])
partir _ [] = ([],[])
partir v (x:xs)
    | x == v = ([],x:xs)
    | otherwise = (x:xs1,xs2) where (xs1,xs2) = partir v xs

-- 6
parts :: [a] -> [[[a]]]
parts l = [take n l:ps | n <- [1..length l], ps <- parts (drop n l)]