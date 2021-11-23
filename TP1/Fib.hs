--import BigNumber 

-- 1.1. fibRec
fibRec :: (Integral a) => a -> a
fibRec 0 = 0
fibRec 1 = 1
fibRec n = fibRec (n-2) + fibRec (n-1)

-- 1.2. fibLista
fibLista :: Int -> Int
fibLista n = map fibRec [0..n] !! n

-- 1.3. fibListaInfinita
fibs :: [Int]
fibs = 0 : 1 : zipWith (+) fibs (tail fibs)

fibListaInfinita :: Int -> Int
fibListaInfinita n = fibs !! n

-- fibRecBN

-- fibListaBN

-- fibListaInfinitaBN