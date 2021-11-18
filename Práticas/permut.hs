permut [] = [[]]
permut (x:xs) = [l | z <- permut xs, l <- intercala x z]