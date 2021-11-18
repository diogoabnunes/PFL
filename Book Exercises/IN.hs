main = print ()
-- IN-5
double x = 2*x
nand x y = not (x && y)
funcX a b c x = 
    a*t^2 + b*t + c
    where t = cos x + sin x
funcX2 a b c x = 
    let t = cos x + sin x in
    a*t^2 + b*t + c

-- IN-6
half x = x / 2
xor x y = x && not y
cbrt x = x**(1/3)
heron a b c = 
    sqrt (s * (s-a) * (s-b) * (s-c))
    where s = (a+b+c)/2
heron2 a b c =
    let s = (a+b+c)/2 in
    sqrt (s * (s-a) * (s-b) * (s-c))

-- IN-7
isTriangular a b c = (a+b<=c) && (a+c<=b) && (b+c<=a)
isPythagorean a b c = (a^2+b^2==c^2) || (a^2+c^2==b^2) || (b^2+c^2==a^2)

-- IN-13
f :: (Ord a, Num a, Integral b) => a -> b
f x
    | x > 0 = 1
    | x < 0 = -1
    | x == 0 = 0
f2 0 = 0
f2 x = if x > 0 then 1 else -1

-- IN-17
f1b 0 = 0
f1b 1 = 1
fib n
    | n > 0 = f1b(n-2) + f1b(n-1)
    | otherwise = error "negative n"

-- IN-18
ackermann 0 n = n+1
ackermann m 0 = ackermann (m-1) 1
ackermann m n
    | m > 0 && n > 0 = ackermann (m-1) (ackermann m (n-1))
    | otherwise = error "negative m or n"