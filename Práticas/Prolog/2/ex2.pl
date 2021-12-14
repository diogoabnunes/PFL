% ['1/ex1.pl'].

ancestor(X, Y) :- parent(X, Y).
ancestor(X, Y) :-
    parent(X, Z),
    ancestor(Z, Y).

descendant(X, Y) :- son(X, Y).
descendant(X, Y) :-
    son(X, Z),
    descendant(Z, Y).