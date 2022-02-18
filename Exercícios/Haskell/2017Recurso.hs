{- 1.
a) [[],[5,2]]
b) [1,4,7,10]
c) 11
d) [0,3,6,9]
e) [1,3,5,7,2]
f) [(1,3),(2,2)]
g) [x | x <-[1,4..32]]
h) 60
i) [a] -> a
j) [[Int] -> Int]
k) Num p => N -> p
l) Ord a => a -> [a] -> [Bool]
-}

-- 2.a) 
maioresQ :: Ord a => [a] -> a -> [a]
maioresQ l x = [y | y <- l, y > x]

-- 2.b)
tamanhoS :: [String] -> [Int]
tamanhoS l = [length y | y <- l]

-- 6
data Arv a = Vazia | No a (Arv a) (Arv a) deriving(Show)

-- 6.a)
listar :: Arv a -> [a]
listar Vazia = []
listar (No a esq dir) = listar esq ++ [a] ++ listar dir

-- 6.b)
simetrica :: Arv a -> Arv a
simetrica Vazia = Vazia
simetrica (No a esq dir) = No a dir esq 