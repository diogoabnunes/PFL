module BigNumber (BigNumber,
    somaBN, subBN, mulBN, divBN,
    safeDivBN,
    maiorBN) where

-- 2.1. Definição do tipo BigNumber (usando a keyword "data")
--data BigNumber = BN [Int]
--    deriving (Eq, Show)
type BigNumber = [Int]
-- TODO: Dúvida prof, como representar em "data"?

-- Remove Left Zeros: Ex.: [0,0,0,1,2,3] -> [1,2,3]
removerZerosEsquerdaBN :: BigNumber -> BigNumber
removerZerosEsquerdaBN [0] = [0]
removerZerosEsquerdaBN (0:xs) = removerZerosEsquerdaBN xs
removerZerosEsquerdaBN xs = xs

-- Mudança de sinal: Ex.: [1,2,3] -> [-1,2,3]
mudarSinalBN :: BigNumber -> BigNumber
mudarSinalBN (x:xs) = (-x):xs

mudarSinalDivBN :: (BigNumber, BigNumber) -> (BigNumber, BigNumber)
mudarSinalDivBN (xs, ys) = (mudarSinalBN xs, mudarSinalBN ys)

-- Verifica se um BN é negativo: Ex.: [-1,2,3] -> True
negativoBN :: BigNumber -> Bool
negativoBN (x:xs) = x < 0

-- Comparação de BigNumber's
auxMaiorBN :: BigNumber -> BigNumber -> Bool
auxMaiorBN [x] [y] = x > y
auxMaiorBN (x:xs) (y:ys)
    | length (x:xs) > length (y:ys) = True
    | length (x:xs) < length (y:ys) = False
    | x /= y = x > y
    | otherwise = auxMaiorBN xs ys

maiorBN :: BigNumber -> BigNumber -> Bool
maiorBN (x:xs) (y:ys)
    | negativoBN (x:xs) && not (negativoBN (y:ys)) = False
    | not (negativoBN (x:xs)) && negativoBN (y:ys) = True
    | negativoBN (x:xs) && negativoBN (y:ys) = auxMaiorBN (-y:ys) (-x:xs)
    | otherwise = auxMaiorBN (x:xs) (y:ys)

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
    | maiorBN a b = removerZerosEsquerdaBN -- (+a)-(+b)=a-b
        (reverse
            (auxSubBN (reverse a) (reverse b) 0))
    | otherwise =  -- (+a)-(+b)=-(+a)-(+b)
        mudarSinalBN (subBN b a)

-- 2.4. mulBN TODO:
mulBN :: BigNumber -> BigNumber -> BigNumber
mulBN a b = a

-- 2.5. divBN
auxDivBN :: BigNumber -> BigNumber -> Int -> (BigNumber, BigNumber)
auxDivBN a b n 
    | maiorBN a b || a == b = -- 120 div 100 (quociente 0) = divInt(120/100) div 100 (quociente 1)
        auxDivBN (subBN a b) b (n+1)
    | otherwise = -- 100 div 120 (quociente 0) = (0, 100 (resto))
        ([n], a)

divBN :: BigNumber -> BigNumber -> (BigNumber, BigNumber)
divBN a b 
    | b == [0] = error "Infinity"
    | negativoBN a && negativoBN b = -- (-a)/(-b)
        divBN (mudarSinalBN a) (mudarSinalBN b)
    | negativoBN a && not (negativoBN b) = -- (-a)/(+b)
        mudarSinalDivBN (divBN (mudarSinalBN a) b)
    | not (negativoBN a) && negativoBN b = -- (+a)/(-b)
        mudarSinalDivBN (divBN a (mudarSinalBN b))
    | not (negativoBN a) && not (negativoBN b) = -- (+a)/(+b)
        auxDivBN a b 0

-- 5. safeDivBN
safeDivBN :: BigNumber -> BigNumber -> Maybe (BigNumber, BigNumber)
safeDivBN a b
    | b == [0] = Nothing
    | otherwise = Just (divBN a b)