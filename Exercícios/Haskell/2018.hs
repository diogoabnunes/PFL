{- 1.
a) ["abc","","dce"]
b) [[2],[],[3],[4]]
c) 10
d) [2,4,6,8]
e) [1,0,-1,-2,-3]
f) [6,7,8,9,10]
g) [4,5,6]
h) [(-1)^x * 2^x | x <- [1..]]
i) 24
j) [a] -> a
k) ([Bool],[Char]) or ([Bool],String)
l) aval:: E a -> (a -> Bool) -> (Bool -> Bool -> Bool) -> Bool
m) [[a]] -> [a]
-}

-- 2.a)
avalia :: [Int] -> [Char]
avalia [] = []
avalia (x:xs) = if x >= 15 then 'A':avalia xs else 'R':avalia xs

-- 2.b)
injust :: [Int] -> Int
injust [] = 0
injust (x:xs) = if x >= 10 && x < 15 then injust xs + 1 else injust xs

-- 3
repete :: a -> [[a]]
repete x = []:[x:l | l <- repete x]

-- 6
data Arv a = Vazia | No a (Arv a) (Arv a)

-- 6.a)
soma :: Num a => Arv a -> a
soma Vazia = 0
soma (No n esq dir) = n + soma esq + soma dir

-- 6.b)
foldtree :: (a -> b -> b -> b) -> b -> Arv a -> b
foldtree f v Vazia = v
foldtree f v (No n esq dir) = f n (foldtree f v esq) (foldtree f v dir)