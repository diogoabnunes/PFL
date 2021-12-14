fatorial(0, 1).
fatorial(N, F) :-
    N > 0,
    N1 is N-1,
    fatorial(N1, F1),
    F is N*F1.

somaRec(0, 0).
somaRec(N, Sum) :-
    N > 0,
    N1 is N-1,
    somaRec(N1, Sum1),
    Sum is N+Sum1.

fibonacci(0, 0).
fibonacci(1, 1).
fibonacci(N, F) :-
    N > 0,
    N1 is N-1, N2 is N-2,
    fibonacci(N1, F1), fibonacci(N2, F2),
    F is F1+F2.

isPrime(2).
isPrime(3).
isPrime(X) :-
    X > 3,
    X mod 2 =\= 0,
    \+divisible(X, 3).

divisible(N, X) :- N mod X =:= 0.
disivible(N, X) :-
    X*X < N,
    X1 is X+2,
    divisible(N, X1).