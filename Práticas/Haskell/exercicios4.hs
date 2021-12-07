import Data.Char 

-- 4.1
primos :: [Integer]
primos = crivo [2..]

crivo :: [Integer] -> [Integer]
crivo (p:xs) = p : crivo [x | x<-xs, x `mod` p/=0]

fatores :: Integer -> [Integer]
fatores 1 = []
fatores n = primo : fatores (n `div` primo)
  where
    primo = head (filter (\p -> n `mod` p == 0) primos)

-- 4.2
calcPi1 :: Int -> Double
calcPi1 n = sum (take n (zipWith (/) (cycle [4,-4]) [1,3..]))

aux :: Double -> Double
aux n = n * (n+1) * (n+2)

calcPi2 :: Int -> Double
calcPi2 n = sum (take n (3 : zipWith(/) (cycle [4,-4]) [aux 2, aux 4..]))

-- 4.3
intercalar :: a -> [a] -> [[a]]
intercalar n [] = [[n]]
intercalar n list = (n : list) : map (head list:)  (intercalar n (tail list))

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
  where
    repeatedStr = concat (replicate ((length x `div` length y) + 1) y)

-- 4.6
-- a
