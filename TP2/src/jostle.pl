
:- [board].
:- use_module(library(random)).

%verify_owner(+Board, +Col, +Row, +Player)
verify_owner(Board, Col, Row, Player) :-
    get_cell_value(Board, Col, Row, Value),   
    Value == Player.

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
    Mrow >= 0.

get_cell_after_move(Col, Row, Move, Col, Mrow):-
    Move == 4,
    Mrow is Row + 1,
    Mrow =< 10.
    
%get_newBoard(+Board, +Player, +Col, +Row, +Mcol, +Mrow, -NewBoard).
get_newBoard(Board, Player, Col, Row, Mcol, Mrow, NewBoard):-
    replace_value_matrix(Board, Col, Row, ' ', TempBoard),
    replace_value_matrix(TempBoard, Mcol, Mrow, Player, NewBoard).

%get_checker_points(+Board, +Col, +Row, -Points)
get_checker_points(Board, Col, Row, Points):-
    get_cell_value(Board, Col, Row, Value),
    get_checker_points(Board, Col, Row, Value, Points, 0, 1).

% quando todos os vizinhos já foram contabilizados  
get_checker_points(_, _, _, _, TempPoints, TempPoints, Move):-
    Move == 5, !.

% vizinhos 1 a 4
get_checker_points(Board, Col, Row, Value, Points, TempPoints, Move):-
    get_cell_after_move(Col, Row, Move, Mcol, Mrow), !,
    get_cell_value(Board, Mcol, Mrow, NeighborVal),
    add_connection_points(Value, NeighborVal, TempPoints, NeighborPoints),
    NextMove is Move + 1,
    get_checker_points(Board, Col, Row, Value, Points, NeighborPoints, NextMove).

% vizinhos 1 a 4, se get_cell_after_move falhar no get_checker_points passar para o vizinho seguinte
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

%verify_points(+Points, +NewPoints).
verify_points(Points, NewPoints):-
    NewPoints > Points.

%change_player(+Player, -Next).
change_player(Player, 'A'):-
    Player == 'V'.
change_player(Player, 'V'):-
    Player == 'A'.

%verify_valid_play(+Board, +Player, +Col, +Row, +Move)  
verify_valid_play(Board, Player, Col, Row, Move) :-
    verify_owner(Board, Col, Row, Player),
    get_cell_after_move(Col, Row, Move, Mcol, Mrow),
    verify_available(Board, Mcol, Mrow),
    get_newBoard(Board, Player, Col, Row, Mcol, Mrow, NewBoard),
    get_checker_points(Board, Col, Row, Points),
    get_checker_points(NewBoard, Mcol, Mrow, NewPoints),
    Points < NewPoints.

%get_next_possible_play(+Col, +Row, +Move, -NextCol, -NextRow, -NextMove)
get_next_possible_play(Col, Row, Move, Col, Row, NextMove):-
    Move < 4,
    NextMove is Move + 1.

get_next_possible_play(Col, Row, 4, NextCol, Row, 1):-
    Col < 9,
    NextCol is Col + 1.

get_next_possible_play(9, Row, 4, 0, NewRow, 1):-
    NewRow is Row + 1.

%get_plays(+Plays) returns a list with all the possible plays (valid or not)
get_plays(Plays):-
    get_plays(0,0,1,Plays).

% ja fica fora do tabuleiro 
get_plays(_, 10, _, []).

get_plays(Col, Row, Move,[[Col,Row,Move]|Tplays]):-
    get_next_possible_play(Col, Row, Move, NextCol, NextRow, NextMove),
    get_plays(NextCol, NextRow, NextMove, Tplays).

%get_valid_plays(+Board, +Player, -Plays)
get_valid_plays(Board, Player, Plays):-
    get_valid_plays(Board, Player, 0, 0, 1, Plays).

% quando passa para a row 10 ja fica fora do tabuleiro 
get_valid_plays(_, _, _, 10, _, []).

get_valid_plays(Board, Player, Col, Row, Move,[[Col,Row,Move]|Tplays]):-
    verify_valid_play(Board, Player, Col, Row, Move), !,
    get_next_possible_play(Col, Row, Move, NextCol, NextRow, NextMove),
    get_valid_plays(Board, Player, NextCol, NextRow, NextMove,Tplays).

% caso a jogada (Col Row Move) não seja valida para o dado Player
get_valid_plays(Board, Player, Col, Row, Move, Tplays):-
    get_next_possible_play(Col, Row, Move, NextCol, NextRow, NextMove),
    get_valid_plays(Board, Player, NextCol, NextRow, NextMove,Tplays).

%get_computer_plays(+Board, +Player, -Play)
get_computer_plays(Board, Player, Play):-
    get_valid_plays(Board, Player, Plays),
    random_member(Play, Plays).

