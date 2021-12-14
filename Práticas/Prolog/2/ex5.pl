list_size([], 0).
list_size([_|T], Size) :-
    list_size(T, SizeT),
    Size is SizeT+1.

list_sum([], 0).
list_sum([H|T], Sum) :-
    list_sum(T, Sum1),
    Sum is H+Sum1.

list_prod([], 1).
list_prod([H|T], Product) :-
    list_prod(T, Product1),
    Product is H*Product1.

inner_product([], [], 0).
inner_product([H1|T1], [H2|T2], Result) :-
    inner_product(T1, T2, Result1),
    Result is (H1*H2)+Result1.

count(_, [], 0).
count(X, [X|T], N) :-
    count(X, T, N1),
    N is N1+1.
count(X, [H|T], N) :-
    X =\= H,
    count(X, T, N1),
    N is N1.