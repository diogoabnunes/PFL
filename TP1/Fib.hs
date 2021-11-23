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
fibRecBN [0] = [0]
fibRecBN [1] = [1]
fibRecBN n = somaBN (fibRecBN (subBN n [2])) (fibRecBN (subBN n [1]))

-- fibsBN: Lista de Fibonacci em BigNumber
fibsBN :: [BigNumber]
fibsBN = [0] : [1] : zipWith somaBN fibsBN (tail fibsBN)

indexAtBN :: [BigNumber] -> BigNumber -> BigNumber
indexAtBN (x:xs) n
    | maiorBN n [0] = indexAtBN xs (subBN n [1])
    | otherwise = x

-- fibListaBN
fibListaBN :: BigNumber -> BigNumber
fibListaBN n
    | n == [0] = [0]
    | n == [1] = [1]
    | otherwise = somaBN
        (indexAtBN auxFibListaBN (subBN n [1]))
        (indexAtBN auxFibListaBN (subBN n [2]))
            where auxFibListaBN = [fibListaBN [num] | num <- [0 .. ]]


-- fibListaInfinitaBN
fibListaInfinitaBN :: BigNumber -> BigNumber
fibListaInfinitaBN = indexAtBN fibsBN