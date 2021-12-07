main = print()
-- 1.3, 1.4, 1.6, 1.7, 1.8, 1.9, 1.12, 1.14, 1.15, 1.16
-- 1.3
metades l =
    let x = length l `div` 2 in
    (take x l, drop x l)

-- 1.4
last1 l = head (drop (length l - 1) l)
last2 l = head (reverse l)
last3 = head . reverse

init1 l = take (length l - 1) l
init2 l = reverse (tail (reverse l))

-- 1.5
binom :: Integer -> Integer -> Integer
binom n k = div (product [1..n]) (product [1..k] * product [1..(n-k)])

binom2 :: Integer -> Integer -> Integer
binom2 n k = div (product [n-k+1..n]) (product [1..k])

-- 1.6
raizes :: Float -> Float -> Float -> (Float, Float)
raizes a b c = ((-b+sqrt delta)/(2*a),
                (-b-sqrt delta)/(2*a))
    where delta = b^2-4*a*c

-- 1.7
{-
a) ['a','b','c'] :: [Char]
b) ('a','b','c') :: (Char, Char, Char)
c) [(False,'0'), (True,'1')] :: [(Bool,Char)]
d) ([False,True], ['0','1']) :: ([Bool], [Char])
e) [tail, init, reverse] :: [[a] -> [a]]
f) [id, not] :: [Bool -> Bool]
-}

-- 1.8
twice f x = f (f x)
{-
a) segundo :: [a] -> a
b) trocar :: (a,b) -> (b,a)
c) par :: a -> b -> (a,b)
d) dobro :: Num a => a -> a
e) metade :: Fractional a => a -> a
f) minuscula :: Char -> Bool
g) intervalo :: Ord a => a -> a -> a -> Bool
h) palindromo :: -> Eq a => [a] -> Bool
i) twice :: (a -> a) -> a -> a
-}

-- 1.9
classifica :: Int -> String
classifica n
    | n <= 9 = "Reprovado"
    | n <= 12 = "Suficiente"
    | n <= 15 = "Bom"
    | n <= 18 = "Muito Bom"
    | otherwise = "Muito Bom com Distincao!"

-- 1.12
xor :: Bool -> Bool -> Bool 
xor False True = True
xor True False = True
xor _ _ = False

-- 1.14
curta1 :: [a] -> Bool
curta1 l
    | length l <= 2 = True 
    | otherwise = False

curta2 :: [a] -> Bool
curta2 [] = True 
curta2 [_] = True 
curta2 [_,_] = True
curta2 _ = False 

-- 1.15
mediana1 :: Ord a => a -> a -> a -> a
mediana1 a b c 
    | a <= b && b <= c = b 
    | a <= c && c <= b = c
    | otherwise = a

mediana2 a b c = 
    a+b+c - maximum - minimum 
    where maximum = max (max a b) (max b c)
          minimum = min (min a b) (min b c)