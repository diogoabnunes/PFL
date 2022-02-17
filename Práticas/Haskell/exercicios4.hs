{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use foldr" #-}
import Data.Char

-- 4.1
primos :: [Integer]
primos = crivo [2..]

crivo :: [Integer] -> [Integer]
crivo (p:xs) = p : crivo [x | x<-xs, mod x p/=0]

fatores :: Integer -> [Integer]
fatores 1 = []
fatores n = primo : fatores (div n primo)
  where primo = head (filter (\p -> mod n p == 0) primos)

-- 4.2
calcPi1 :: Int -> Double
calcPi1 n = sum (take n (zipWith (/) (cycle [4,-4]) [1,3..]))

aux :: Double -> Double
aux n = n * (n+1) * (n+2)

calcPi2 :: Int -> Double
calcPi2 n = sum (take n (3 : zipWith(/) (cycle [4,-4]) [aux 2, aux 4..]))

-- 4.3 
intercalar :: a -> [a] -> [[a]]
intercalar x ys = (x:ys) : intercalarAux x 1 ys

intercalarAux :: a -> Int -> [a] -> [[a]]
intercalarAux x i ys
  | length ys < i = []
  | otherwise = (take i ys ++ (x:drop i ys)) : intercalarAux x (i + 1) ys

-- 4.4
unique :: (Eq a) => [a] -> [a]
unique [] = []
unique (x : xs)
  | x `elem` xs = unique xs
  | otherwise = x : unique xs

perms :: [Int] -> [[Int]]
perms [] = []
perms [c] = [[c]]
perms l = unique (concat ([intercalar (l !! i) possibility | i <- [0 .. n - 1], possibility <- perms (auxList !! i)]))
  where
    auxList = zipWith (\n l -> take n l ++ drop (n + 1) l ) [0 .. n] (replicate n l)
    n = length l

-- 4.5
returnNext :: Char -> Int -> [Char]
returnNext c k = [chr (65 + ((ord c - 65 + k) `mod` 26))]

getDesl :: Char -> Int
getDesl x = ord x - 65

cifraChave :: String -> String -> String
cifraChave x y = concatMap (\k -> returnNext (fst k) (getDesl (snd k))) (zip x repeatedStr)
  where repeatedStr = concat (replicate ((length x `div` length y) + 1) y)

-- 4.6.a)
pascal :: [[Int]]
pascal = [ [fromInteger (binom3 (fromIntegral n) (fromIntegral k)) | k <- [0 .. n] ] | n <- [0 ..] ]

-- 4.6.b)
binom3 :: Integer -> Integer -> Integer
binom3 n k
    | k == 0 || n == k = 1
    | otherwise = binom3 (n - 1) (k - 1) + binom3 (n - 1) k

-- 4.7
data Arv a = Vazia | No a (Arv a) (Arv a) deriving Show

sumArv :: Num a => Arv a -> a 
sumArv Vazia = 0
sumArv (No n a b) = n + sumArv a + sumArv b 

-- 4.8
listar :: Arv a -> [a]
listar Vazia = []
listar (No n a b) = listar b ++ [n] ++ listar a

-- 4.9
nivel :: Int -> Arv a -> [a]
nivel _ Vazia = []
nivel 0 (No n _ _) = [n]
nivel n (No node a b) = nivel (n-1) a ++ nivel (n-1) b

-- 4.10
mapArv :: (a -> b) -> Arv a -> Arv b 
mapArv _ Vazia = Vazia 
mapArv f (No n a b) = No (f n) (mapArv f a) (mapArv f b)

-- 4.11
-- Construção por inserção simples
construir :: Ord a => [a] -> Arv a
construir [] = Vazia
construir (x:xs) = inserir x (construir xs)

inserir :: Ord a => a -> Arv a -> Arv a
inserir x Vazia = No x Vazia Vazia
inserir x (No y esq dir)
  | x==y = No y esq dir -- já ocorre; não insere
  | x<y = No y (inserir x esq) dir -- insere à esquerda
  | x>y = No y esq (inserir x dir) -- insere à direita

-- 4.12.a)
maisDir :: Arv a -> a
maisDir (No n _ Vazia) = n
maisDir (No _ _ dir) = maisDir dir

-- 4.12.b)
remover :: Ord a => a -> Arv a -> Arv a 
remover _ Vazia = Vazia 
remover a (No n esq Vazia)
  | a == n = esq
  | otherwise = remover a esq 
remover a (No n Vazia dir)
  | a == n = dir 
  | otherwise = remover a dir
remover a (No n esq dir)
  | a < n = No n (remover a esq) dir 
  | a > n = No n esq (remover a dir)
  | otherwise = No (maisDir esq) (remover (maisDir esq) esq) dir