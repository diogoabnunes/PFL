{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use guards" #-}
{-# HLINT ignore "Use init" #-}
{-# HLINT ignore "Use last" #-}
{-# HLINT ignore "Use !!" #-}
{-# HLINT ignore "Use splitAt" #-}

-- 1.1
testaTriangulo :: Float -> Float -> Float -> Bool
testaTriangulo a b c = (a < b+c) && (b < a+c) && (c < a+b)

-- 1.2
areaTriangulo :: Float -> Float -> Float -> Float
areaTriangulo a b c = sqrt (s*(s-a)*(s-b)*(s-c)) where s = (a+b+c)/2

-- 1.3
metades :: [Int] -> ([Int], [Int])
metades l = (take half l, drop half l) where half = div (length l) 2

-- 1.4.a)1
last1 :: [Int] -> Int
last1 l = head (drop (length l - 1) l)

-- 1.4.a)2
last2 :: [Int] -> Int
last2 l = head (reverse l)

-- 1.4.b)1
init1 :: [Int] -> [Int]
init1 l = take (length l - 1) l

-- 1.4.b)2
init2 :: [Int] -> [Int]
init2 l = reverse (tail (reverse l))

-- 1.5.a)
binom :: Integer -> Integer -> Integer
binom n k = div (product [1..n]) (product [1..k] * product [1..(n-k)])

-- 1.5.b)
binom' :: Integer -> Integer -> Integer
binom' n k
    | k < n - k = div (product [(n-k+1)..n]) (product [1..k])
    | otherwise = div (product [(k+1)..n]) (product [1..(n-k)])

-- 1.6
raizes :: Float -> Float -> Float -> (Float, Float)
raizes a b c = ((-b-sqrt delta)/2*a,
                (-b+sqrt delta)/2*a)
    where delta = b^2 - 4*a*c

-- 1.7
{-
a) ['a','b','c'] :: [Char]
b) ('a','b','c') :: (Char,Char,Char)
c) [(False,'0'),(True,'1')] :: [(Bool,Char)]
d) ([False,True],['0','1']) :: ([Bool],[Char])
e) [tail,init,reverse] :: [[a] -> [a]]
f) [id,not] :: [Bool -> Bool]
-}

-- 1.8
{-
a) segundo :: [a] -> a
segundo xs = head (tail xs)

b) trocar :: (a,b) -> (b,a)
trocar (x, y) = (y, x)

c) par :: a -> b -> (a,b)
par x y = (x, y)

d) dobro :: Num a => a -> a
dobro x = 2 ∗x

e) metade :: Fractional a => a -> a
metade x = x/2

f) minuscula :: Char -> Bool
minuscula x = x ≥′a′&& x ≤′z′

g) intervalo :: Ord a => a -> a -> a -> Bool
intervalo x a b = x ≥a && x ≤b

h) palindromo :: -> Eq a => [a] -> Bool
palindromo xs = reverse xs == xs

i) twice :: (a -> a) -> a -> a
twice f x = f (f x)
-}

-- 1.9
classificaNota :: Int -> String
classificaNota nota
    | nota <= 9 = "reprovado"
    | nota <= 12 = "suficiente"
    | nota <= 15 = "bom"
    | nota <= 18 = "muito bom"
    | otherwise = "muito bom como distincao"

-- 1.10
classificaIMC :: Float -> Float -> String
classificaIMC peso altura
    | imc < 18.5 = "baixo peso"
    | imc < 25 = "peso normal"
    | imc < 30 = "excesso de peso"
    | otherwise = "obesidade"
    where imc = peso / altura^2

-- 1.11.a)
max', min' :: Ord a => a -> a -> a
max' x y = if x>=y then x else y
min' x y = if x<=y then x else y

max3a, min3a, max3b, min3b :: Ord a => a -> a -> a -> a
max3a x y z = if x>=y && x>=z then x else if y>=z then y else z
min3a x y z = if x<=y && x<=z then x else if y<=z then y else z

-- 1.11.b)
max3b a b c = max a (max b c)
min3b a b c = min a (min b c)

-- 1.12
xor :: Bool -> Bool -> Bool
xor True False = True
xor False True = True
xor _ _ = False

-- 1.13
safetail1, safetail2, safetail3 :: [a] -> [a]
safetail1 l = if null l then [] else tail l
safetail2 l
    | null l = []
    | otherwise = tail l
safetail3 [] = []
safetail3 l = tail l

-- 1.14
curta1, curta2 :: [a] -> Bool
curta1 l = length l < 3
curta2 l
    | null (tail l) = True
    | null (tail (tail l)) = True
    | null (tail (tail (tail l))) = True
    | otherwise = False

-- 1.15.a)
mediana1 :: (Num a, Ord a) => a -> a -> a -> a
mediana1 a b c
    | a <= b && b <= c = b
    | a <= c && c <= b = c
    | otherwise = a

-- 1.15.b)
mediana2 :: (Num a, Ord a) => a -> a -> a -> a
mediana2 a b c = a + b + c - maximum - minimum
    where maximum = max a (max b c)
          minimum = min a (min b c)

-- 1.16
unidades :: [String]
unidades = ["zero","um","dois","tres","quatro","cinco","seis","sete","oito","nove"]

dezAdezanove :: [String]
dezAdezanove = ["dez","onze","doze","treze","quatorze","quinze","dezasseis","dezassete","dezoito","dezanove"]

dezenas :: [String]
dezenas = ["vinte","trinta","quarenta","cinquenta","sessenta","setenta","oitenta","noventa"]

{-
  A função 'converte2' é composição de duas:
  * 'divide2' obtêm os algarimos;
  * 'combina2' combina o texto de cada algarismo.
  Usamos as operações de concatenação (++) e
  indexação de listas (!!) (note que os índices começam em zero.)
-}
converte2 :: Int -> String
converte2 n | n<100 = combina2 (divide2 n)

divide2 :: Int -> (Int, Int)
divide2 n = (div n 10, mod n 10) -- (quociente,resto)

combina2 :: (Int, Int) -> String
combina2 (0, u) = unidades !! u
combina2 (1, u) = dezAdezanove !! u
combina2 (d, 0) = dezenas !! (d-2)
combina2 (d, u) = dezenas !! (d-2) ++ " e " ++ unidades !! u

{- Em seguida, resolvemos o problema análogo para números até 3
   algarismos. Necessitamos dos nomes em Português das centenas.
 -}
centenas :: [String]
centenas = ["cento","duzentos","trezentos","quatrocentos","quinhentos","seiscentos","setecentos","oitocentos","novecentos"]

{- A função de conversão, nos mesmos moldes da anterior.
   Note o tratamento especial do número 100.  -}
converte3 :: Int -> String
converte3 n | n<1000 = combina3 (divide3 n)

divide3 :: Int -> (Int, Int)
divide3 n = (div n 100, mod n 100)

combina3 :: (Int, Int) -> String
combina3 (0, n) = converte2 n
combina3 (1, 0) = "cem"
combina3 (c, 0) = centenas !! (c-1)
combina3 (c, n) = centenas !! (c-1) ++ " e " ++ converte2 n

{- Finalmente podemos resolver o problema para números
  até 6 algarismos, i.e. inferiores a 1 milhão.  -}
converte6 :: Int -> String
converte6 n | n<1000000 = combina6 (divide6 n)

divide6 n = (div n 1000, mod n 1000)

combina6 (0, n) = converte3 n
combina6 (1, 0) = "mil"
combina6 (1, n) = "mil" ++ ligar n ++ converte3 n
combina6 (m, 0) = converte3 m ++ " mil"
combina6 (m, n) = converte3 m ++ " mil" ++ ligar n ++ converte3 n

{- Uma função auxiliar para escolher a partícula de ligação entre
   milhares e o restante (r).
   Regra: colocamos "e" quando o resto é inferior a 100
   ou múltiplo de 100; caso contrario, basta um espaço.
 -}
ligar :: Int -> String
ligar r
  | r < 100 || r `mod` 100 == 0 = " e "
  | otherwise                   = " "

-- A solução do exercício proposto é converte6.
converte :: Int -> String
converte = converte6
------------------------------------------------------------------------

{- MY VERSION
converte :: Int -> String
converte n
    | n <= 9 = unidades !! n
    | n <= 19 = dezDezanove !! (n - 10)
    | n <= 100 = dezenas !! (div n 10 - 2) ++ " e " ++ unidades !! mod n 10
    | n == 100 = "cem"
    | n <= 999 = centenas !! (div n 100 - 1) ++ " e " ++ converte (mod n 100)
    | n == 1000 = "mil"
    | n <= 1999 = "mil " ++ converte (mod n 1000)
    | n <= 9999 = unidades !! div n 1000 ++ " mil " ++ converte (mod n 1000)
    | n <= 999999 = converte (div n 1000) ++ " mil " ++ converte (mod n 1000)
    | otherwise = "um milhao"

unidades = ["zero", "um", "dois", "tres", "quatro", "cinco", "seis", "sete", "oito", "nove"]
dezDezanove = ["dez", "onze", "doze", "treze", "catorze", "quinze", "dezasseis", "dezassete", "dezoito", "dezanove"]
dezenas = ["vinte", "trinta", "quarenta", "cinquenta", "sessenta", "setenta", "oitenta", "noventa"]
centenas = ["cento", "duzentos", "trezentos", "quatrocentos", "quinhentos", "seiscentos", "setecentos", "oitocentos", "novecentos"]
-}