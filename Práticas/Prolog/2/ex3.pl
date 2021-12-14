% ['1/ex5.pl'].

superior(X, Y) :- chefiado_por(Y, X).
superior(X, Y) :-
    chefiado_por(Z, X),
    chefiado_por(Y, Z).