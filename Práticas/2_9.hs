import Data.Char

-- Converter Char para inteiro
charToInt c = ord c - ord 'A'

-- Converter inteiro para Char
intToChar n = chr (n + ord 'A')

-- Verificar se letra é maiúscula: isUpper

-- Desloca k posições
desloca :: Int -> Char -> Char 
desloca k x
    | isUpper x = intToChar ((charToInt x + k) `mod` 26)
    | otherwise = x

-- Repete o deslocamento para a string
cifra :: Int -> [Char] -> [Char]
cifra k s = [desloca k x | x <- s]