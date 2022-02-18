{- 1.
a) [1,2]
b) [7,5,3,1]
c) [1,2,3]
d) 4
e) "cdr"
f) [(2,'a'),(3,'b'),(4,'c')]
g) 12
h) [(Int,Int)]
i) [[a] -> [a]]
j) Num a => [a] -> [a]
-}

-- 2
transforma :: String -> String 
transforma [] = []
transforma (c:str)
    | c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u' = c:'p':c:transforma str 
    | otherwise = c:transforma str 

-- 3
subidas :: [Float] -> Int 
subidas [] = 0
subidas [x] = 0
subidas (x:y:ys) = if y > x then subidas (y:ys) + 1 else subidas (y:ys)

-- 4
data Arv a = F | N a (Arv a) (Arv a)

-- 4.a)
alturas :: Arv a -> Arv Int
alturas F = F 
alturas (N _ F F) = N 1 F F 
alturas (N _ esq F) = N (n+1) esquerdo F where esquerdo@(N n _ _) = alturas esq
alturas (N _ F dir) = N (n+1) F direito where direito@(N n _ _) = alturas dir 
alturas (N _ esq dir) = N (max a b + 1) esquerdo direito
    where esquerdo@(N a _ _) = alturas esq 
          direito@(N b _ _) = alturas dir

-- 4.b)
equilibrada :: Arv a -> Bool 
equilibrada F = True 
equilibrada (N _ F F) = True 
equilibrada (N _ esq F) = n <= 1 where (N n _ _) = alturas esq
equilibrada (N _ F dir) = n <= 1 where (N n _ _) = alturas dir 
equilibrada (N _ esq dir) = max a b - min a b <= 1
    where (N a _ _) = alturas esq 
          (N b _ _) = alturas dir
