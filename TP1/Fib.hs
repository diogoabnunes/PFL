import BigNumber

-- 1.1. fibRec
fibRec :: (Integral a) => a -> a
fibRec 0 = 0
fibRec 1 = 1
fibRec n = fibRec (n-2) + fibRec (n-1)

-- 1.2. fibLista
fibLista :: Int -> Int
fibLista n = map fibRec [0..n] !! n

-- fibs: Lista de Fibonacci em Int
fibs :: [Int]
fibs = 0 : 1 : zipWith (+) fibs (tail fibs)

-- 1.3. fibListaInfinita
fibListaInfinita :: Int -> Int
fibListaInfinita n = fibs !! n

-- fibRecBN
fibRecBN :: BigNumber -> BigNumber
fibRecBN (Negative n) = error "There is no negative index"
fibRecBN (Positive [0]) = Positive [0]
fibRecBN (Positive [1]) = Positive [1]
fibRecBN (Positive n) = somaBN
                (fibRecBN (subBN (Positive n) (Positive [2])))
                (fibRecBN (subBN (Positive n) (Positive [1])))

-- fibsBN: Lista de Fibonacci em BigNumber
fibsBN :: [BigNumber]
fibsBN = Positive [0] : Positive [1] : zipWith somaBN fibsBN (tail fibsBN)

-- indexAtBN: Equivalente ao uso de !! com inteiros
indexAtBN :: [BigNumber] -> BigNumber -> BigNumber
indexAtBN (x:xs) n
    | maiorBN n (Positive [0]) = indexAtBN xs (subBN n (Positive [1]))
    | otherwise = x

-- fibListaBN
fibListaBN :: BigNumber -> BigNumber
fibListaBN (Negative a) = error "There is no negative index"
fibListaBN (Positive n)
    | n == [0] = Positive [0]
    | n == [1] = Positive [1]
    | otherwise = somaBN
        (indexAtBN auxFibListaBN (subBN (Positive n) (Positive [1])))
        (indexAtBN auxFibListaBN (subBN (Positive n) (Positive [2])))
            where auxFibListaBN = [fibListaBN (Positive [num]) | num <- [0 .. ]]

-- fibListaInfinitaBN
fibListaInfinitaBN :: BigNumber -> BigNumber
fibListaInfinitaBN (Negative a) = error "There is no negative index"
fibListaInfinitaBN (Positive a) = indexAtBN fibsBN (Positive a)