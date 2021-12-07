main :: IO ()
main = print ()
-- LI-2

-- LI-10
myCycle :: [a] -> [a]
myCycle l = l ++ myCycle l
-- LI-34
dropN :: Integral p => [a] -> p -> [a]
dropN l n =  [x | (x,p) <- zip l [1..], mod p 3 /= 0] -- using zip on natural numbers
dropN' :: Integral p => [a] -> p -> [a]
dropN' l n = [x | (x,p) <- zip l (cycle [1..n]), p /= n] -- using zip on cycle
-- LI-37
myCycle' :: [a] -> [a]
myCycle' l = [x | _ <- [1..], x <- l]
-- LI-38
--a
myE :: Int -> Double
myE n = sum (take n eFactors)
eFactors :: [Double]
eFactors = 1:[prev/k | (prev,k) <- zip eFactors [1..]]
--b
myPi :: (Floating a, Enum a) => Int -> a
myPi n = sqrt (12 * sum (take n [((-1)**k)/(k+1)^2 | k <- [0..]]))
-- LI-40
--a -> ERRO NAS SOLUÇOES
doubleSquare :: [Integer]
doubleSquare = [if even i then 2*i else 2^i-1 | i <- [0..]]
--b
fib :: [Integer]
fib = 1:1:[prev1 + prev2 | (prev1,prev2) <- zip fib(tail fib)]
-- LI-41
--a
cipher :: Int -> [Char] -> [Char]
cipher n str = [cipherChar | c <- str, (char,cipherChar) <- codes n, c == char]
codes :: Int -> [(Char, Char)]
codes n = zip ['a' .. 'z'] (drop (mod n 26) (cycle ['a' .. 'z']))
--b
decipher :: Int -> [Char] -> [Char]
decipher n str = [char | c <- str, (char, cipherChar) <- codes n, c == cipherChar]
-- LI-42
f :: [Integer]
f = g [2 ..]
g :: Integral a => [a] -> [a]
g (x:xs) = x:g [x' | x' <- xs, mod x' x /= 0]