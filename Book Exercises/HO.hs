-- HO-1
twice f x = f (f x)

-- HO-19
myIterate f x = x:[f prev | prev <- myIterate f x]

-- HO-24
hamming :: Integral a => [a]
-- hamming = 1:(map (2*) hamming) ++ (map (3*) hamming) ++ (map (5*) hamming)
-- Problem: Not ordered, gets stuck on infinite loop only producing powers of 2
hamming = 1:((map (2*) hamming) `merge` (map (3*) hamming) `merge` (map (5*) hamming))
merge :: (Integral a) => [a] -> [a] -> [a]
merge (x:xs) (y:ys)
    | x < y = x:(xs `merge` (y:ys))
    | y < x = y:((x:xs) `merge` ys)
    | otherwise = x:(xs `merge` ys)