{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use newtype instead of data" #-}
{-# HLINT ignore "Use infix" #-}

module Stack (Stack, push, pop, top, empty, isEmpty) where

data Stack a = Stk [a]

push :: a -> Stack a -> Stack a
push x (Stk xs) = Stk (x:xs)

pop :: Stack a -> Stack a
pop (Stk (_:xs)) = Stk xs
pop _ = error "Stack.pop: empty stack"

top :: Stack a -> a
top (Stk (x:_)) = x
top _ = error "Stack.top: empty stack"

empty :: Stack a
empty = Stk []

isEmpty :: Stack a -> Bool
isEmpty (Stk [])= True
isEmpty (Stk _) = False

-- 5.1
parent :: String -> Bool 
parent s = parentAux s (Stk [])

parentAux :: String -> Stack Char -> Bool 
parentAux [] st
    | isEmpty st = True 
    | otherwise = False
parentAux (x:xs) st 
    | x == '[' || x == '(' = parentAux xs (push x st)
    | not (isEmpty st) && x == ')' && top st == '(' ||
      not (isEmpty st) && x == ']' && top st == '[' = parentAux xs (pop st)
    | otherwise = False 

-- 5.2
calc :: Stack Float -> String -> Stack Float 
calc st s
    | s == "+" = push (top (pop st) + top st) (pop (pop st))
    | s == "-" = push (top (pop st) - top st) (pop (pop st))
    | s == "*" = push (top (pop st) * top st) (pop (pop st))
    | s == "/" = push (top (pop st) / top st) (pop (pop st))
    | otherwise = push (read s) st 

calcular :: String -> Float
calcular s = top (last listaStack)
    where
        listaStack = empty : [calc (listaStack !! i) x | (x, i) <- zip z [0 .. length z - 1]]
        z = words s

main :: IO()
main = do
    a <- getLine 
    print (calcular a)

-- 5.3
{-
import Data.List

data UniqList a = UList [a]

push :: Eq a => UniqList a -> a -> UniqList a
push (UList []) item = UList [item]
push (UList list) item
    | item `elem` list = UList list
    | otherwise = UList (list ++ [item])

delete :: Eq a => UniqList a -> a -> UniqList a 
delete (UList []) _ = UList []
delete (UList list ) item
    | item `elem` list = UList (Data.List.delete item list)
    | otherwise = UList list
-}

-- 5.4
data Set a = Empty | Node a (Set a) (Set a) deriving Show

empty' :: Set a 
empty' = Empty

insert' :: Ord a => a -> Set a -> Set a
insert' a Empty = Node a Empty Empty
insert' a (Node n esq dir)
    | a < n = Node n (insert' a esq) dir 
    | a > n = Node n esq (insert' a dir)
    | otherwise = Node n esq dir 

member' :: Ord a => a -> Set a -> Bool 
member' a Empty = False 
member' a (Node n esq dir)
    | a < n = member' a esq 
    | a > n = member' a dir 
    | otherwise = True

-- 5.5
union, intersect, difference :: Ord a => Set a -> Set a -> Set a

union n Empty = n 
union Empty n = n 
union (Node a esq dir) b = union esq (union dir (if member' a b then b else insert' a b))

intersect _ Empty = Empty
intersect Empty _ = Empty
intersect a b = intersectAux a b Empty

intersectAux :: Ord a => Set a -> Set a -> Set a -> Set a
intersectAux Empty _ res = error "First set empty"
intersectAux a (Node val l r) res
    | member' val a && not (member' val res) = intersectAux a l (intersectAux a r (insert' val res))
    | otherwise = intersectAux a l (intersectAux a r res)
intersectAux a Empty res = res

difference Empty _ = Empty
difference a Empty = a
difference a b = differenceAux b a Empty

differenceAux :: Ord a => Set a -> Set a -> Set a -> Set a
differenceAux Empty _ res = error "First set empty"
differenceAux a (Node val l r) res
    | not (member' val a || member' val res) = differenceAux a l (differenceAux a r (insert' val res))
    | otherwise = differenceAux a l (differenceAux a r res)
differenceAux a Empty res = res

-- 5.6
{-
module Map (Map, empty'', insert'', Map.lookup) where

data Map k v = Empty | Node (k,v) (Map k v) (Map k v) deriving Show

empty'' :: Map k v
empty'' = Empty

insert'' :: Ord k => k -> v -> Map k v -> Map k v
insert'' k v Empty = Node (k,v) Empty Empty
insert'' k v (Node (k1,v1) l r)
  | k < k1 = Node (k1,v1) (insert'' k v l) r
  | k > k1 = Node (k1,v1) l (insert'' k v r)
  | otherwise = Node (k,v) l r

lookup :: Ord k => k -> Map k v -> Maybe v
lookup _ Empty = Nothing
lookup k (Node (k1,v1) l r)
  | k < k1 = Map.lookup k l
  | k > k1 = Map.lookup k r
  | otherwise = Just v1
-}

-- 5.7
newtype Set' a = Set (a -> Bool)

member''' :: a -> Set' a -> Bool 
member''' a (Set f) = f a

union''' :: Set' a -> Set' a -> Set' a
union''' (Set f1) (Set f2) = Set (\x -> f1 x || f2 x)

intersect''' :: Set' a -> Set' a -> Set' a
intersect''' (Set f1) (Set f2) = Set (\x -> f1 x && f2 x)

difference''' :: Set' a -> Set' a -> Set' a
difference''' (Set f1) (Set f2) = Set (\x -> f1 x && not (f2 x))