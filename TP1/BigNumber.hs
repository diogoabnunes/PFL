module BigNumber (BigNumber (..),
    scanner, output,
    somaBN, auxSomaBN, subBN, auxSubBN, 
    mulBN, auxMulBN, adicionarZerosBN,
    divBN, auxDivBN, carryBN, auxCarryBN, carryPairBN,
    safeDivBN,
    removerZerosEsquerdaBN, mudarSinalBN, mudarSinalDivBN,
    auxMaiorBN, maiorBN,
    removeBN, appendBN, reverseBN
    ) where

-- 2.1. Definição do tipo BigNumber (usando a keyword "data")
data BigNumber = Positive [Int] | Negative [Int] deriving (Show)

-- Função auxiliar: Remoção dos Zeros à esquerda
removerZerosEsquerdaBN :: BigNumber -> BigNumber
removerZerosEsquerdaBN (Positive [0]) = Positive [0]
removerZerosEsquerdaBN (Negative [0]) = Negative [0]
removerZerosEsquerdaBN (Positive (0:xs)) = removerZerosEsquerdaBN (Positive xs)
removerZerosEsquerdaBN (Negative (0:xs)) = removerZerosEsquerdaBN (Negative xs)
removerZerosEsquerdaBN (Positive xs) = Positive xs
removerZerosEsquerdaBN (Negative xs) = Negative xs

-- Função auxiliar: Mudança de sinal de um BigNumber
mudarSinalBN :: BigNumber -> BigNumber
mudarSinalBN (Positive a) = Negative a
mudarSinalBN (Negative a) = Positive a

-- Mudança de sinal de um par de BigNumber's
mudarSinalDivBN :: (BigNumber, BigNumber) -> (BigNumber, BigNumber)
mudarSinalDivBN (a, b) = (mudarSinalBN a, mudarSinalBN b)

-- Comparação de BigNumber's
auxMaiorBN :: BigNumber -> BigNumber -> Bool
auxMaiorBN (Positive [a]) (Positive [b]) = a > b
auxMaiorBN (Positive (x:xs)) (Positive (y:ys))
    | length (x:xs) > length (y:ys) = True
    | length (x:xs) < length (y:ys) = False
    | x /= y = x > y
    | otherwise = auxMaiorBN (Positive xs) (Positive ys)

-- Verificação se um BigNumber é maior que outro
maiorBN :: BigNumber -> BigNumber -> Bool
maiorBN (Negative a) (Positive b) = False
maiorBN (Positive a) (Negative b) = True
maiorBN (Negative a) (Negative b) = maiorBN (Positive b) (Positive a)
maiorBN (Positive a) (Positive b) = auxMaiorBN
    (removerZerosEsquerdaBN (Positive a))
    (removerZerosEsquerdaBN (Positive b))

-- Remoção de um elemento/caractere de uma lista/string -> usado no scanner
removeBN :: Eq a => [a] -> a -> [a]
removeBN [] a = []
removeBN (x:xs) a
    | x == a = removeBN xs a
    | otherwise = x:removeBN xs a

-- Função a:b mas adaptada a BigNumber's
appendBN :: Int -> BigNumber -> BigNumber
appendBN a (Positive b) = Positive (a:b)

-- Função reverse mas adaptada a BigNumber's
reverseBN :: BigNumber -> BigNumber
reverseBN (Positive n) = Positive (reverse n)
reverseBN (Negative n) = Negative (reverse n)

-- 2.2. scanner
scanner :: String -> BigNumber
scanner str
    | head str == '-' = Negative (map (\x -> read[x]) (removeBN str '-'))
    | otherwise = Positive (map (\x -> read[x]) str)

-- 2.3. output
output :: BigNumber -> String
output (Positive a) = concatMap show a
output (Negative a) = "-" ++ concatMap show a

-- 2.4. somaBN
auxSomaBN :: BigNumber -> BigNumber -> Int -> BigNumber
auxSomaBN (Positive []) (Positive []) 0 = Positive []
auxSomaBN (Positive []) (Positive []) a = Positive [a]
auxSomaBN (Positive (x:xs)) (Positive []) a = Positive ((x+a):xs)
auxSomaBN (Positive []) (Positive (y:ys)) a = Positive ((y+a):ys)
auxSomaBN (Positive (x:xs)) (Positive (y:ys)) a
    | x+y+a < 10 = appendBN (x+y+a) (auxSomaBN (Positive xs) (Positive ys) 0)
    | otherwise = appendBN (x+y+a-10) (auxSomaBN (Positive xs) (Positive ys) 1)

somaBN :: BigNumber -> BigNumber -> BigNumber
somaBN (Positive a) (Negative b) = subBN (Positive a) (Positive b)
somaBN (Negative a) (Positive b) = subBN (Positive b) (Positive a)
somaBN (Negative a) (Negative b) = mudarSinalBN (somaBN (Positive a) (Positive b))
somaBN (Positive a) (Positive b) = removerZerosEsquerdaBN
            (reverseBN
                    (auxSomaBN
                        (Positive (reverse a))
                        (Positive (reverse b))
                        0))

-- 2.5. subBN
auxSubBN :: BigNumber -> BigNumber -> Int -> BigNumber
auxSubBN (Positive []) (Positive []) _ = Positive []
auxSubBN (Positive [a]) (Positive [b]) c
    | a-b-c >= 0 = appendBN (a-b-c) (auxSubBN (Positive []) (Positive []) 0)
    | otherwise = appendBN (10-b-c) (auxSubBN (Positive []) (Positive []) 1)
auxSubBN (Positive (x:xs)) (Positive []) c
    | x-c >= 0 = appendBN (x-c) (auxSubBN (Positive xs) (Positive []) 0)
    | otherwise = appendBN (10-c) (auxSubBN (Positive xs) (Positive []) 1)
auxSubBN (Positive (x:xs)) (Positive (y:ys)) c
    | x-y >= 0 = appendBN (x-y) (auxSubBN (Positive xs) (Positive ys) 0)
    | otherwise = appendBN (10+x-y) (auxSubBN (Positive xs) (Positive ys) 1)

subBN :: BigNumber -> BigNumber -> BigNumber
subBN (Negative a) (Negative b) = subBN (Positive b) (Positive a)
subBN (Negative a) (Positive b) = somaBN (Negative a) (Negative b)
subBN (Positive a) (Negative b) = somaBN (Positive a) (Positive b)
subBN (Positive a) (Positive b)
    | maiorBN (Positive a) (Positive b) = removerZerosEsquerdaBN
        (reverseBN
            (auxSubBN
                (Positive (reverse a))
                (Positive (reverse b))
                0))
    | maiorBN (Positive b) (Positive a) = mudarSinalBN (subBN (Positive b) (Positive a))
    | otherwise = Positive [0]

-- -- 2.6. mulBN 
adicionarZerosBN :: BigNumber -> Int -> BigNumber
adicionarZerosBN (Positive a) n = Positive (a ++ map (*0) [1..n])

auxMulBN :: BigNumber -> BigNumber -> BigNumber
auxMulBN (Positive a) (Positive [x]) = carryBN ( Positive (map (* x) a) ) 
auxMulBN (Positive a) (Positive (x:xs)) = 
    somaBN 
        (adicionarZerosBN 
            ( carryBN ( Positive (map (* x) a) ) )
            (length xs)
        )
        (auxMulBN (Positive a) (Positive xs) )

mulBN :: BigNumber -> BigNumber -> BigNumber
mulBN (Negative a) (Negative b) = mulBN (Positive a) (Positive b)
mulBN (Negative a) (Positive b) = mudarSinalBN (mulBN (Positive a) (Positive b))
mulBN (Positive a) (Negative b) = mudarSinalBN (mulBN (Positive a) (Positive b))
mulBN (Positive a) (Positive b)
    | maiorBN (Positive b) (Positive a) = mulBN (Positive b) (Positive a)
    | otherwise = auxMulBN (Positive a) (Positive b)

-- 2.7. divBN
auxCarryBN :: BigNumber -> Int -> BigNumber
auxCarryBN (Positive []) a = Positive [a]
auxCarryBN (Positive (x:xs)) a = appendBN (mod (x+a) 10) (auxCarryBN (Positive xs) (div (x+a) 10))

carryBN :: BigNumber -> BigNumber
carryBN (Positive xs) = removerZerosEsquerdaBN
    (reverseBN
        (auxCarryBN
            (Positive (reverse xs))
            0))

carryPairBN :: (BigNumber, BigNumber) -> (BigNumber, BigNumber)
carryPairBN (xs, ys) = (carryBN xs, carryBN ys)

auxDivBN :: BigNumber -> BigNumber -> Int -> (BigNumber, BigNumber)
auxDivBN (Positive a) (Positive b) n
    | maiorBN (Positive a) (Positive b) || a == b =
        carryPairBN
            (auxDivBN
                (subBN (Positive a) (Positive b))
                (Positive b)
                (n+1))
    | otherwise =
        (carryBN (Positive [n]), carryBN (Positive a))

divBN :: BigNumber -> BigNumber -> (BigNumber, BigNumber)
divBN (Positive a) (Positive [0]) = error "Infinity"
divBN (Negative a) (Positive [0]) = error "Infinity"
divBN (Negative a) (Negative b) = divBN (Positive a) (Positive b)
divBN (Negative a) (Positive b) = mudarSinalDivBN (divBN (Positive a) (Positive b))
divBN (Positive a) (Negative b) = mudarSinalDivBN (divBN (Positive a) (Positive b))
divBN (Positive a) (Positive b) = auxDivBN (Positive a) (Positive b) 0

-- 5. safeDivBN
safeDivBN :: BigNumber -> BigNumber -> Maybe (BigNumber, BigNumber)
safeDivBN (Positive a) (Positive b)
    | b == [0] = Nothing
    | otherwise = Just (divBN (Positive a) (Positive b))
safeDivBN (Positive a) (Negative b)
    | b == [0] = Nothing
    | otherwise = Just (divBN (Positive a) (Negative b))
safeDivBN (Negative a) (Positive b)
    | b == [0] = Nothing
    | otherwise = Just (divBN (Negative a) (Positive b))
safeDivBN (Negative a) (Negative b)
    | b == [0] = Nothing
    | otherwise = Just (divBN (Negative a) (Negative b))