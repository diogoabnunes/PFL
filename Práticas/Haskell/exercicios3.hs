-- 3.1
-- [f x | x ←xs, p x]
{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use maximum" #-}
{-# HLINT ignore "Use minimum" #-}
f :: Num a => a -> a
f x = 2*x
p :: Integral a => a -> Bool
p = even
f' :: Integral a => [a] -> [a]
f' l = map f (filter p l)

-- 3.2
aux :: Num a => a -> a -> a
aux x y = 10 * x + y
dec2int :: [Int] -> Int
dec2int = foldl aux 0

-- 3.3
zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' f (x:xs) (y:ys) = f x y : zipWith' f xs ys
zipWith' _ _ _ = []

-- 3.4
insert :: Ord a => a -> [a] -> [a]
insert x [] = [x]
insert x (y:ys) = if x <= y then x:y:ys
                  else y : insert x ys
isort :: Ord a => [a] -> [a]
isort = foldr insert []

-- 3.5.a)
myMaximum, myMinimum :: Ord a => [a] -> a
myMaximum = foldl1 max
myMinimum = foldl1 min

-- 3.5.b)
foldl1' f l = foldl f head l (tail l) -- many solutions
foldr1' f l = foldr f init l (last l) -- many solutions

-- 3.6
mdc :: Integral t => t -> t -> t
mdc a b = if b == 0 then a else mdc b (mod a b)
mdc' :: Integral a => a -> a -> (a, a)
mdc' a b = until (\(x,y) -> y == 0) (\(x,y) -> (y, mod x y)) (a,b)

-- 3.7 until 3.15: TODO: