-- fibRec
fibRec :: (Integral a) => a -> a
fibRec 0 = 0
fibRec 1 = 1
fibRec n = fibRec(n-2) + fibRec(n-1)
    -- n >= 0 = fibRec(n-2) + fibRec(n-1)
    -- | otherwise = error "Error: Negative input"

--fibLista
fibLista :: Int -> Int
fibLista n = map fibRec [0..n] !! n

--fibListaInfinita
fibListaInfinita :: Num a => Int -> a
fibListaInfinita n = fibLI !! n
    where fibLI = 0 : 1 : zipWith (+) fibLI (tail fibLI)

-- fibRecBN

-- fibListaBN

-- fibListaInfinitaBN