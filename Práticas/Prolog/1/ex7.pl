a(a1, 1). 
a(A2, 2). 
a(a3, N). 
b(1, b1). 
b(2, B2). 
b(N, b3). 
c(X, Y):- a(X, Z), b(Z, Y). 
d(X, Y):- a(X, Z), b(Y, Z). 
d(X, Y):- a(Z, X), b(Z, Y).

/*
i. a(A, 2).         -> yes
ii. b(A, foobar).   -> A = 2
iii. c(A, b3).      -> A = A1
iv. c(A, B).        -> A = a1, B = b1 ; A = a1, B = b3.
v. d(A, B).         -> [...] (muitas hipóteses)
*/