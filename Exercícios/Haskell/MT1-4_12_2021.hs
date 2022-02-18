{-
Parte 1
1. data Arv a = Folha | No a (Arv a) (Arv a)
2. [Int]
3. Apenas A e C
4. [1,2,3,1,2,3,...]
5. (1,2)
6. [(2,3)]
7. [2,1]
8. 13
9. [a] -> a
10. [Int] -> [Bool]
11. [('a',1), ('a',2), ('b',1), ('b',2), ('c',1), ('c',2)]
12. "bb"
-}

-- 1
maxpos :: [Int] -> Int
maxpos [] = 0
maxpos [x] = if x > 0 then x else 0
maxpos (x:y:xs) = if x > y then maxpos (x:xs) else maxpos (y:xs)

-- 2
dups :: [a] -> [a]
dups [] = []
dups [x] = [x,x]
dups (x:y:xs) = x:x:y:dups xs

-- 3
transforma :: String -> String
transforma [] = []
transforma (x:xs)
    | x == 'a' || x == 'e' || x == 'i' || x == 'o' || x == 'u' = x:'p':x:transforma xs
    | otherwise = x:transforma xs

-- 4
type Vector = [Int]
type Matriz = [[Int]]

transposta :: Matriz -> Matriz
transposta m = [[(m !! j) !! i  | j <- [0..(length m - 1)] ] | i <- [0..(length (head m) - 1)]]

-- 5
prodInterno :: Vector -> Vector -> Int
prodInterno v1 v2 = sum (zipWith (*) v1 v2)

-- 6
prodMat :: Matriz -> Matriz -> Matriz
prodMat m1 m2 = [[ prodInterno (getRow row m1) (getColumn col m2)  | col <- [0..(length (head m2) - 1)] ] | row <- [0..(length m1 - 1)]]
    where   getColumn col m = [m !! row !! col | row <- [0..(length m -1)]]
            getRow row m = m !! row

-- 7
data Arv a = F | N a (Arv a) (Arv a) deriving(Show)

alturas :: Arv a -> Arv Int
alturas F = F
alturas (N _ F F) = N 1 F F
alturas (N _ F dir) = N (1+b) F direito where direito@(N b _ _) = alturas dir
alturas (N _ esq F) = N (1+a) esquerdo F where esquerdo@(N a _ _) = alturas esq
alturas (N _ esq dir) = N (1 + max a b) esquerdo direito
    where esquerdo@(N a _ _) = alturas esq
          direito@(N b _ _) = alturas dir

-- 8
equilibrada :: Arv a -> Bool
equilibrada F = True
equilibrada (N _ F F) = True
equilibrada (N _ F dir) = b <= 1 where (N b _ _) = alturas dir
equilibrada (N _ esq F) = a <= 1 where (N a _ _) = alturas esq
equilibrada (N _ esq dir) = max a b - min a b <= 1 where (N a _ _) = alturas esq
                                                         (N b _ _) = alturas dir

-- 9
f :: (a -> b -> c) -> b -> a -> c
f a b c = a c b