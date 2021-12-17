list_append([],L2,L2).
list_append([H|T],L2,[H|T3]) :-
    list_append(T,L2,T3).

list_member(X,[X|_]).
list_member(X,[H|T]) :-
    X \= H,
    list_member(X,T).

list_last([H|T],R) :-
    append([H],T,[R|T]).

list_nth(0,[X|_],X).
list_nth(N,[_|T],X) :-
    N > 0,
    N1 is N-1,
    list_nth(N1,T,X).

list_append(L1,R) :- list_append_aux(L1,[],R).

list_append_aux([],L,L).
list_append_aux([H|T],Acc,L) :-
    append(Acc,H,R),
    list_append_aux(T,R,L).

list_del(L1,X,R) :- 
    append(La,[X|Lb],L1),!,
    append(La,Lb,R).

list_before(X,Y,L) :-
    append(_,[X|Lb],L),
    append(_,[Y|_],Lb).

list_replace_one(X,Y,L1,L2) :-
    append(La,[X|Lb],L1),
    append(La,[Y|Lb],L2).

list_repeated(X,L) :-
    append(_,[X|Lb],L),
    append(_,[X|_],Lb).

list_slice(L1,I,N,R) :-
    append(La,Lb,L1),
    length(La, I),
    append(R,_,Lb),
    length(R,N).

list_shift_rotate(L1,N,R) :-
    append(La,Lb,L1),
    length(La, N),
    append(Lb,La,R).