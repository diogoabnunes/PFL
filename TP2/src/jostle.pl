
:- [board].

%veriify_owner(+Board, +Col, +Row, +Player)
veriify_owner(Board, Col, Row, Player) :-
    get_cell_value(Board, Col, Row, Value),   
    Value == Player,!.

%veriify_move_choice(+Board, +Player, +Move):-
veriify_move_choice(_, _, Move):-
   ( Move == 1 ; 
    Move == 2; 
    Move == 3; 
    Move == 4) ,!.

veriify_move_choice(Board, Player, Move):-
    Move == 5, !,nl, 
    game_pvp(Board, Player).

%get_cell_after_move(+Col, +Row, +Move, -Mcol, -Mrow)
get_cell_after_move(Col, Row, Move, Mcol, Row):-
    Move == 1, !,
    Mcol is Col + 1,
    Mcol =< 10.

get_cell_after_move(Col, Row, Move, Mcol, Row):-
    Move == 2, !,
    Mcol is Col - 1,
    Mcol >= 0.

get_cell_after_move(Col, Row, Move, Col, Mrow):-
    Move == 3, !,
    Mrow is Row - 1,
    Mrow =< 10.

get_cell_after_move(Col, Row, Move, Col, Mrow):-
    Move == 4, !,
    Mrow is Row + 1,
    Mrow =< 10,!.
    
%get_newBoard(+Board, +Player, +Col, +Row, +Mcol, +Mrow, -NewBoard).
get_newBoard(Board, Player, Col, Row, Mcol, Mrow, NewBoard):-
    replace_value_matrix(Board, Col, Row, ' ', TempBoard),
    replace_value_matrix(TempBoard, Mcol, Mrow, Player, NewBoard).

%change_player(+Player, -Next).
change_player(Player, 'A'):-
    Player == 'V'.
change_player(Player, 'V'):-
    Player == 'A'.

%get_checker_points(+Board, +Col, +Row, -Points)
get_checker_points(Board, Col, Row, Points):-
    get_cell_value(Board, Col, Row, Value),
    get_checker_points(Board, Col, Row, Value, Points, 0, 1).

% todos os vizinhos já foram contabilizados  
get_checker_points(_, _, _, _, TempPoints, TempPoints, Move):-
    Move == 5.

% vizinhos 1 a 4
get_checker_points(Board, Col, Row, Value, Points, TempPoints, Move):-
    get_cell_after_move(Col, Row, Move, Mcol, Mrow), !,
    get_cell_value(Board, Mcol, Mrow, NeighborVal),
    add_connection_points(Value, NeighborVal, TempPoints, NeighborPoints),
    NextMove is Move + 1,
    get_checker_points(Board, Col, Row, Value, Points, NeighborPoints, NextMove).

% vizinhos 1 a 4, se get_cell_after_move falhar passar para o vizinho seguinte
get_checker_points(Board, Col, Row, Value, Points, TempPoints, Move):-
    NextMove is Move + 1,
    get_checker_points(Board, Col, Row, Value, Points, TempPoints, NextMove).

%add_connection_points(+Value, +NeighborVal, +TempPoints, -NeighborPoints)
add_connection_points(Value, NeighborVal, TempPoints, NeighborPoints):-
    Value == NeighborVal, !,
    NeighborPoints is TempPoints + 1.

add_connection_points(_, NeighborVal, TempPoints, TempPoints):-
    NeighborVal == ' ', !.

add_connection_points(_, _, TempPoints, NeighborPoints):-
    NeighborPoints is TempPoints - 1.
