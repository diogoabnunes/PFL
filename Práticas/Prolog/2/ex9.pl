rle(L1,R) :- rle_aux(L1,[],R).

rle_aux([],L,L).
rle_aux([H|T],Acc,R) :- append(La,[H-X|Lb],Acc),
                        X1 is X+1,
                        append(La,[H-X1|Lb],L),
                        rle_aux(T,L,R),
                        !.
rle_aux([H|T],Acc,R) :- \+member(H,Acc),
                        append(Acc,[H-1],L1),
                        rle_aux(T,L1,R).

un_rle(L1,R) :- un_rle(L1,[],R).

un_rle([],L,L).
un_rle([P-V|T],Acc,R) :-
    un_rle_aux(V,P,Acc,L),
    un_rle(T,L,R).

un_rle_aux(0,_,L,L).
un_rle_aux(N,X,Acc,L) :-
    N > 0,
    N1 is N - 1,
    append(Acc,[X],L1),
    un_rle_aux(N1,X,L1,L).