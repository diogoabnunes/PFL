
:- [board].

%get_cell_after_move(+Col, +Row, +Move, -Mcol, -Mrow)

get_cell_after_move(Col, Row, Move, Mcol, Row):-
    Move == 1,
    Mcol is Col + 1,
    Mcol =< 1,!.

get_cell_after_move(Col, Row, Move, Mcol, Row):-
    Move == 2,
    Mcol is Col - 1,
    Mcol >= 0, !.

get_cell_after_move(Col, Row, Move, Col, Mrow):-
    Move == 3,
    Mrow is Row - 1,
    Mrow =< 10,!.

get_cell_after_move(Col, Row, Move, Col, Mrow):-
    Move == 4,
    Mrow is Row + 1,
    Mrow =< 10,!.

get_cell_after_move(_, _, _, _, _):-  
    write('Out of bounds of the board').
    
%get_newBoard(+Board, =Player, +Col, +Row, +Mcol, +Mrow, -NewBoard).
get_newBoard(Board, Player, Col, Row, Mcol, Mrow, NewBoard):-
    replace_value_matrix(Board, Col, Row, ' ', TempBoard),
    replace_value_matrix(TempBoard, Mcol, Mrow, Player, NewBoard).

%change_player(+Player, -Next).
change_player(Player, 'A'):-
    Player == 'V'.
change_player(Player, 'V'):-
    Player == 'A'.