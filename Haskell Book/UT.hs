-- UT-1
type HashMap k v = [(k,v)]
-- a
type IntMap v = HashMap Int v
-- b
mapInt :: IntMap Char
mapInt = [(1, 'a'), (2, 'b'), (3, 'c')]
mapString :: HashMap Char Bool
mapString = [('a', True), ('b', False), ('c', True)]
-- c
member :: Eq k => k -> HashMap k v -> Bool
member _ [] = False
member x ((k,v):kvs)
    | x == k = True
    | otherwise = member x kvs
-- d
keySum :: IntMap v -> Int
keySum [] = 0
keySum ((k,v):kvs) = k + keySum kvs
-- UT-2
-- a
type Pos = (Int, Int)
-- b
rookMoves :: Pos -> [Pos]
rookMoves (row, col) =
    [(row1, col) | row1 <- [1..8], row1 /= row] ++
    [(row, col1) | col1 <- [1..8], col1 /= col]

-- UT-3
type Pair a = (a, a)
-- a
type Relation a = [Pair a]
-- b
isReflexive :: (Eq a) => Relation a -> Bool
isReflexive r = isReflexiveAux r r

isReflexiveAux :: (Eq a) => [Pair a] -> Relation a -> Bool
isReflexiveAux [] _ = True
isReflexiveAux ((x,y):xs) r
    | (y,x) `elem` r = isReflexiveAux xs r
    | otherwise = False

-- c
isTransitive :: (Eq a) => Relation a -> Bool
isTransitive r = isTransitiveAux [(x,y) | x <- r, y <- r] r

isTransitiveAux:: (Eq a) => [Pair (Pair a)] -> Relation a -> Bool
isTransitiveAux [] _ = True
isTransitiveAux (((x,y), (w,z)):xs) r
    | y == w && notElem (x,z) r = False
    | otherwise = isTransitiveAux xs r

-- UT-4
-- type Pos = (Int, Int)
queenMoves :: Pos -> [Pos]
queenMoves (row, col) =
    [(row1, col) | row1 <- [1..8], row1 /= row] ++
    [(row, col1) | col1 <- [1..8], col1 /= col] ++
    [(row', col') | dir <- [-1,1], offset <- [-7,-6.. -1] ++ [1..7],
        let row' = row+offset, let col' = col+offset*dir,
        row >= 1, row' <= 8, col' >= 1, col' <= 8]
-- UT-5
data Shape = Circle Double Double Double | Rectangle Double Double Double Double
area :: Shape -> Double
area (Circle _ _ r) = pi*r^2
area (Rectangle x1 y1 x2 y2) = abs((x1-x2)*(y1-y2))
-- UT-6
perimeter :: Shape -> Double
perimeter (Circle _ _ r) = 2*pi*r
perimeter (Rectangle x1 y1 x2 y2) = 2*(abs(x1-x2)+abs(y1-y2))
-- UT-7
-- type HashMap k v = [(k,v)]
-- a
myLookup :: (Eq k) => k -> HashMap k v -> Maybe v
myLookup _ [] = Nothing
myLookup x ((k,v):kvs)
    | x == k = Just v
    | otherwise = myLookup x kvs
-- b
areEqual :: (Eq k, Eq v) => HashMap k v -> HashMap k v -> Bool
areEqual l1 l2 =
    (length l1 == length l2) && l1 `isContainedIn` l2
isContainedIn :: (Eq k, Eq v) => HashMap k v -> HashMap k v -> Bool
[] `isContainedIn` _ = True
((k,v):kvs) `isContainedIn` l2 =
    case myLookup k l2 of (Just v2) -> v == v2 && kvs `isContainedIn` l2

ceilingKey :: (Eq k, Ord k) => k -> HashMap k v -> Maybe k
ceilingKey k m = ceilingKeyAux k m Nothing
ceilingKeyAux :: (Eq k, Ord k) => k -> HashMap k v -> Maybe k -> Maybe k
ceilingKeyAux _ [] acc = acc
ceilingKeyAux k ((k1,v1):kvs) Nothing 
    | k1 >= k = ceilingKeyAux k kvs (Just k1)
    | otherwise = ceilingKeyAux k kvs Nothing
ceilingKeyAux k ((k1,v1):kvs) (Just kC)
    | k1 >= k && k1 < kC = ceilingKeyAux k kvs (Just k1)
    | otherwise= ceilingKeyAux k kvs (Just kC)
-- UT-8
data NestedList a = Elem a | List [NestedList a]
-- b
flatten :: NestedList a -> [a]
flatten (Elem a) = [a]
flatten (List []) = []
flatten (List (x:xs)) = flatten x ++ flatten (List xs)
-- UT-9
data Country = Ct {
    name :: String, population :: Int, 
    surface_area :: Double, continent :: String
} deriving (Show, Eq)
populationDensity :: Country -> Double
populationDensity c = fromIntegral(population(c)) / surface_area(c)

countContinent :: String -> [Country] -> Int
countContinent cont l = length (filter (== cont) (map continent l))