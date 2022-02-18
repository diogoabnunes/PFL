{- 1.
a) 4
b) []
c) 22
d) [True,True,True,False,False]
e) 26
f) [(2,1),(3,2),(4,3)]
g) [(x,2^y) | (x,y) <- zip [1,3..] [1,2..]]
h) [2,4,2,10,12]
i) (Ord a, Num a) => [a -> Bool]
j) Num c => c -> c
k) data Arv = Folha a | No esq dir
l) Num a -> [a] -> [a] -> a
-}

-- 2.a)
nafrente :: Char -> [String] -> [String]
nafrente c l = [c:x | x <- l]

-- 2.b)
ocorreN :: Eq a => a -> [a] -> Int -> Bool 
ocorreN x l n = length (filter (== x) l) == n

-- 3.a)
subs :: [a] -> [[a]]
subs [] = [[]]
subs (x:xs) = [x:sublist | sublist <- subs xs] ++ subs xs

-- 5.a)
data ArvT a = Folha a | No (ArvT a) (ArvT a) (ArvT a) deriving(Show)

arv :: ArvT Int 
arv = No (Folha 1) (No (Folha 4) (Folha 5) (Folha 8)) (Folha 9)

-- 5.b)
nelementos :: ArvT a -> Int 
nelementos (Folha a) = 1
nelementos (No a b c) = nelementos a + nelementos b + nelementos c

-- 5.c)
mapTree :: (t -> ArvT a) -> ArvT t -> ArvT a
mapTree f (Folha a) = f a
mapTree f (No a b c) = No (mapTree f a) (mapTree f b) (mapTree f c)

