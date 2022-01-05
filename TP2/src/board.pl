%verify_available(+Board, +Col, +Row)
verify_available(Board, Col, Row) :-
    get_cell_value(Board, Col, Row, Value), !,
    Value == ' '.

%get_cell_value(+Board, +Col, +Row, -Val)
get_cell_value(Board, Col, Row, Val) :-
    get_cell_value(Board, Col, Row, 0, Val).

get_cell_value([_|T], Col, Row, Counter, Val):-
    Counter < Row,
    C is Counter + 1,
    get_cell_value(T, Col, Row, C, Val).

get_cell_value([H|_], Col, Row, Counter, Value):-
    Counter == Row,
    check_value(H, Col, Value).

check_value([H|T], Col, Val):-
    check_value([H|T], Col, Val, 0).

check_value([_|T], Col, Val, Counter):-
    Counter < Col, !,
    C is Counter + 1,
    check_value(T, Col, Val, C).

check_value([H|_], Col, H, Counter):-
    Counter == Col.

%replace_value_matrix(+Board, +Col, +Row, Val, -NewBoard).
replace_value_matrix(Board, Col, Row, Val, NewBoard) :-
    replace_value_matrix(Board, Col, Row, Val, [], NewBoard, 0).

replace_value_matrix([H|T], Col, Row, Val, TmpList, NewBoard, Counter) :-
    Counter < Row,
    C is Counter + 1,
	concat(TmpList, [H], Tmp),
    replace_value_matrix(T, Col, Row, Val, Tmp, NewBoard, C).

replace_value_matrix([H|T], Col, Row, Val, TmpList, NewBoard, Counter) :-
    Counter == Row,
    replace_value_list(H, Col, Val, NewRow),
	concat(TmpList, [NewRow], Tmp1),
	concat(Tmp1, T, NewBoard). 

concat([], L, L).
concat([X|L1], L2, [X|L3]) :- concat(L1, L2, L3).

%replace_value_list---------------------------------------------------------------------

replace_value_list([H|T], Pos, Val, L):-
    replace_value_list([H|T], 0, Pos, Val, [], L).

replace_value_list([_H|T], Pos, Pos, Val, TmpList, L) :-
    concat(TmpList, [Val|T], L).

replace_value_list([H|T], Pos_Ini, Pos, Val, TmpList, L) :-
    Pos_Ini < Pos,
    I is Pos_Ini + 1,
    concat(TmpList, [H], Tmp),
    replace_value_list(T, I, Pos, Val, Tmp, L).
