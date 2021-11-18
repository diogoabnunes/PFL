-- 4.1
primos :: [Integer]
primos = crivo [2..]

crivo :: [Integer] -> [Integer]
crivo (p:xs) = p : crivo [x | x<-xs, x `mod` p/=0]

factores :: Int -> [Int]
factores x = 