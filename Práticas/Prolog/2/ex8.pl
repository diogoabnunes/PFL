list_to(N,L) :- list_to_aux(N,[],L).

list_to_aux(0,L,L).
list_to_aux(N, Acc, L) :-
    N > 0,
    N1 is N-1,
    list_to_aux(N1,[N|Acc],L).

list_from_to(Inf,Sup,R) :- list_from_to_aux(Inf,Sup,[],R).

list_from_to_aux(Inf,Sup,Acc,L) :-
    Sup >= Inf,
    N is Sup-1,
    list_from_to_aux(Inf,N,[Sup|Acc],L),
    !.
list_from_to_aux(_,_,L,L).

list_from_to_step(Inf,Step,Sup,R) :- list_from_to_step_aux(Inf,Step,Sup,[],R).

list_from_to_step_aux(Inf,Step,Sup,Acc,L) :- 
    Inf =< Sup,
    N is Inf + Step,
    append(Acc,[Inf],S),
    list_from_to_step_aux(N,Step,Sup,S,L),
    !.
list_from_to_step_aux(_,_,_,L,L).

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

primes(N,L) :- primes_aux(N,[],L).

primes_aux(1,L,L).
primes_aux(N,Acc,L) :-
    N > 1,
    N1 is N - 1,
    (isPrime(N) -> primes_aux(N1,[N|Acc],L) ; primes_aux(N1,Acc,L)).

fibonacci(0, 0).
fibonacci(1, 1).
fibonacci(N, F) :-
    N > 0,
    N1 is N-1, N2 is N-2,
    fibonacci(N1, F1), fibonacci(N2, F2),
    F is F1+F2.

fibs(N,L) :-
    N1 is N - 1,
    fibs_aux(N1,[],L1),
    (N =:= 0 -> append([],L1,L) ; append([0],L1,L)).

fibs_aux(0,L,L).
fibs_aux(N,Acc,L) :-
    N > 0,
    N1 is N - 1,
    fibonacci(N,F),
    fibs_aux(N1,[F|Acc],L).

