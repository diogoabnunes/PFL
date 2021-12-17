invert(List1, List2) :- rev(List1, [], List2).

rev([], R, R).
rev([H|T], L, R) :-
    rev(T, [H|L], R).

del_one(X,L1,L2) :- 
    append(La,[X|Lb],L1),!,
    append(La,Lb,L2).

del_all(X,L,L) :- \+member(X,L).
del_all(X,L1,L2) :- 
    del_one(X,L1,L),!, 
    del_all(X,L,L2).

del_all_list([],L,L).
del_all_list([H|T],L1,L2) :-
    del_all(H,L1,R),
    del_all_list(T,R,L2).

del_dups(L1,L2) :-
    del_dups_aux(L1,[],R),
    invert(R,L2).
        
del_dups_aux([],L,L).
del_dups_aux([H|T],L,L2) :- \+ member(H,L), del_dups_aux(T,[H|L],L2).
del_dups_aux([H|T],L,L2) :- member(H,L), del_dups_aux(T,L,L2).

list_perm([],L) :- L =:= [].
list_perm([H|T],L2) :-
    del_one(H,L2,L),
    list_perm(T,L).

my_replicate(N,X,L) :- replicate_aux(N,X,[],L).

replicate_aux(0,_,L,L).
replicate_aux(N,X,L1,L) :-  
    N > 0,
    N1 is N-1,
    replicate_aux(N1,X,[X|L1],L).

intersperse(X,[H|T],R) :-
    intersperse_aux(X,T,[H],R1),
    invert(R1,R).

intersperse_aux(_,[],R,R).
intersperse_aux(X,[H|T],L1,R) :- intersperse_aux(X,T,[H,X|L1],R).

insert_elem(I,L,E,R) :-
    insert_elem_aux(I,L,E,[],R1),
    invert(R1,R).

insert_elem_aux(_,[],_,L,L).
insert_elem_aux(0,[H|T],X,L1,R) :- insert_elem_aux(-1,T,X,[H,X|L1],R).
insert_elem_aux(I,[H|T],X,L1,R) :- 
    I =\= 0,
    I1 is I - 1,
    insert_elem_aux(I1,T,X,[H|L1],R).

delete_elem(I,L,E,R) :- 
    delete_elem_aux(I,L,E,-1,[],R1),
    invert(R1,R).

delete_elem_aux(_,[],_,_,L,L).
delete_elem_aux(0,[H|T],X,_,L1,R) :- delete_elem_aux(-1,T,X,H,L1,R).
delete_elem_aux(I,[H|T],X,X1,L1,R) :- 
    I =\= 0,
    I1 is I-1,
    delete_elem_aux(I1,T,X,X1,[H|L1],R).

replace(L1,I,O,N,L2) :-
    delete_elem(I,L1,O,L),
    insert_elem(I,L,N,L2).