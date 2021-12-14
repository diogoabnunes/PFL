invert(List1, List2) :- rev(List1, [], List2).

rev([], R, R).
rev([H|T], L, R) :-
    rev(T, [H|L], R).

del_one(_, [], []).
del_one(Elem, [Elem|T], T).
del_one(Elem, [H|T], [H|TF]) :-
    Elem =\= H,
    del_one(Elem, T, TF).

del_all(_, [], []).
del_all(Elem, [Elem|T], TF) :-
    del_one(Elem, T, TF).
del_all(Elem, [H|T], [H|TF]) :-
    Elem =\= H,
    del_one(Elem, T, TF).

    % to complete