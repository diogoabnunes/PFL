--module BigNumber (BigNumber,
--    somaBN, subBN, mulBN, divBN,
--    safeDivBN) where

-- 2.1. Definição do tipo BigNumber (usando a keyword "data")
--data BigNumber = BN [Int]
--    deriving (Eq, Show)
type BigNumber = [Int]
-- TODO: Dúvida prof, como representar em "data"?
-- TODO: Dúvida prof, soma e sub funcionam só para valores (listas) positivos.
-- É suposto tratar caso sejam negativos? Sim, é suposto tratar.
-- Ou deduz-se que são sempre positivos? Não, não se deduz.

-- Remove Left Zeros: Ex.: [0,1,2,3] -> [1,2,3]
removerZerosEsquerdaBN :: BigNumber -> BigNumber
removerZerosEsquerdaBN [0] = [0]
removerZerosEsquerdaBN (0:xs) = xs
removerZerosEsquerdaBN xs = xs

-- Mudança de sinal: Ex.: [1,2,3] -> [-1,2,3]
mudarSinalBN :: BigNumber -> BigNumber
mudarSinalBN (x:xs) = (-x):xs

-- Verifica se um BN é negativo: Ex.: [-1,2,3] -> True
negativoBN :: BigNumber -> Bool
negativoBN (x:xs) = x < 0

-- 2.2. somaBN
auxSomaBN :: (Num t, Ord t) => [t] -> [t] -> t -> [t]
auxSomaBN [] [] 0 = []
auxSomaBN [] [] a = [a]
auxSomaBN (x:xs) [] a = (x+a):xs
auxSomaBN [] (y:ys) a = (y+a):ys
auxSomaBN (x:xs) (y:ys) a
    | (x+y+a) < 10 = (x+y+a):auxSomaBN xs ys 0
    | otherwise = (x+y+a-10):auxSomaBN xs ys 1 -- Carry

somaBN :: BigNumber -> BigNumber -> BigNumber
somaBN a b
    | not (negativoBN a) && not (negativoBN b) = -- (+a)+(+b)=(+a)+(+b)
        removerZerosEsquerdaBN 
            (reverse
                (auxSomaBN (reverse a) (reverse b) 0))
    | not (negativoBN a) && negativoBN b = -- (+a)+(-b)=(+a)-(+b)
        subBN a (mudarSinalBN b)
    | negativoBN a && not (negativoBN b) = -- (-a)+(+b)=(+b)-(+a)
        subBN b (mudarSinalBN a)
    | negativoBN a && negativoBN b = -- (-a)+(-b)=-((+a)+(+b))
        mudarSinalBN (somaBN (mudarSinalBN a) (mudarSinalBN b))

-- 2.3. subBN
auxSubBN :: (Num t, Ord t) => [t] -> [t] -> t -> [t]
auxSubBN [] [] _ = []
auxSubBN [x] [y] a 
    | (x-y-a) >= 0 = (x-y-a):auxSubBN [] [] 0
    | otherwise = (10-y-a):auxSubBN [] [] 1
auxSubBN (x:xs) [] a
    | (x-a) >= 0 = (x-a):auxSubBN xs [] 0
    | otherwise = (10-a):auxSubBN xs [] 1
auxSubBN (x:xs) (y:ys) a 
    | (x-y) >= 0 = (x-y):auxSubBN xs ys 0
    | otherwise = (10+x-y):auxSubBN xs ys 1

subBN :: BigNumber -> BigNumber -> BigNumber
subBN a b
    | a == b = [0]
    | negativoBN a && negativoBN b = -- (-a)-(-b)=(+b)-(a)
        subBN (mudarSinalBN b) (mudarSinalBN a)
    | negativoBN a && not (negativoBN b) = -- (-a)-(+b)=(-a)+(-b)
        somaBN a (mudarSinalBN b)
    | not (negativoBN a) && negativoBN b = -- (+a)-(-b)=(+a)+(+b)
        somaBN a (mudarSinalBN b)
    | a > b = removerZerosEsquerdaBN -- (+a)-(+b)=a-b
        (reverse
            (auxSubBN (reverse a) (reverse b) 0))
    | a < b =  -- (+a)-(+b)=-(+a)-(+b)
        mudarSinalBN (subBN b a)

-- 2.4. mulBN
--mulBN :: BigNumber -> BigNumber -> BigNumber

-- 2.5. divBN -> TODO: buggy qnd entra em auxDivBN -> a > b
auxCarryBN :: Integral t => [t] -> t -> [t]
auxCarryBN [] a = [a]
auxCarryBN (x:xs) a = mod (x+a) 10 : auxCarryBN xs (div (x+a) 10)

carryBN :: BigNumber -> BigNumber
carryBN xs = removerZerosEsquerdaBN (reverse (auxCarryBN (reverse xs) 0))

auxDivBN :: BigNumber -> BigNumber -> Int -> (BigNumber, BigNumber)
auxDivBN a b n 
    | a > b || a == b =
        auxDivBN (subBN a b) b (n+1)
    | otherwise = (carryBN [n], carryBN a)

divBN :: BigNumber -> BigNumber -> (BigNumber, BigNumber)
divBN a b 
    | negativoBN a && negativoBN b = -- (-a)/(-b)
        divBN (mudarSinalBN a) (mudarSinalBN b)
    | negativoBN a && not (negativoBN b) = -- (-a)/(+b)
        divBN (mudarSinalBN a) b
    | not (negativoBN a) && negativoBN b = -- (+a)/(-b)
        divBN a (mudarSinalBN b)
    | otherwise = -- (+a)/(+b)
        auxDivBN a b 0