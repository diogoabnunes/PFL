--module BigNumber (BigNumber,
--    somaBN, subBN, mulBN, divBN,
--    safeDivBN) where

-- 2.1. Definição do tipo BigNumber (usando a keyword "data")
--data BigNumber = BN [Int]
--    deriving (Eq, Show)
type BigNumber = [Int]
-- TODO: Dúvida prof, como representar em "data"?
-- TODO: Dúvida prof, soma e sub funcionam só para valores (listas) positivos.
-- É suposto tratar caso sejam negativos?
-- Ou deduz-se que são sempre positivos?

-- Remove Left Zeros: Ex.: [0,1,2,3] -> [1,2,3]
removerZerosEsquerdaBN :: BigNumber -> BigNumber
removerZerosEsquerdaBN [0] = [0]
removerZerosEsquerdaBN (0:xs) = xs
removerZerosEsquerdaBN xs = xs

-- Mudança de sinal: Ex.: [1,2,3] -> [-1,2,3]
mudarSinalBN :: BigNumber -> BigNumber
mudarSinalBN (x:xs) = (-x):xs

-- 2.2. somaBN
auxSomaBN :: (Num t, Ord t) => [t] -> [t] -> t -> [t]
auxSomaBN [] [] 0 = []
auxSomaBN [] [] a = [a]
auxSomaBN (x:xs) [] a = (x+a):xs
auxSomaBN [] (y:ys) a = (y+a):ys
auxSomaBN (x:xs) (y:ys) a
    | (x+y+a) < 10 = (x+y+a):auxSomaBN xs ys 0
    | otherwise = (x+y+a-10):auxSomaBN xs ys 1

somaBN :: BigNumber -> BigNumber -> BigNumber
somaBN a b = removerZerosEsquerdaBN 
    (reverse
        (auxSomaBN (reverse a) (reverse b) 0))

-- 2.3. subBN
auxSubBN :: (Num t, Ord t) => [t] -> [t] -> t -> [t]
auxSubBN [] [] 0 = []
auxSubBN [] [] a = [a]
auxSubBN (x:xs) [] a
    | (x-a) >= 0 = (x-a):auxSubBN xs [] 0
    | otherwise = (10-a):auxSubBN xs [] 1
auxSubBN [x] [y] a 
    | (x-y-a) >= 0 = (x-y-a):auxSubBN [] [] 0
    | otherwise = (10-y-a):auxSubBN [] [] 1
auxSubBN (x:xs) (y:ys) a 
    | (x-y) >= 0 = (x-y):auxSubBN xs ys 0
    | otherwise = (x-y+10):auxSubBN xs ys 1

subBN :: BigNumber -> BigNumber -> BigNumber
subBN a b
    | a > b = removerZerosEsquerdaBN
        (reverse
            (auxSubBN (reverse a) (reverse b) 0))
    | a < b = mudarSinalBN
        (removerZerosEsquerdaBN
            (reverse 
                (auxSubBN (reverse b) (reverse a) 0)))
    | otherwise = [0]

-- 2.4. mulBN
--mulBN :: BigNumber -> BigNumber -> BigNumber

-- 2.5. divBN
--divBN :: BigNumber -> BigNumber -> BigNumber

