/*
    Regulations
*/
:- [display].
:- [jostle].
:- [input].

% initialize values ----------------------------------------------------

init_board([
    [' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],
    [' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],
    [' ',' ','V','A','V','A','V','A',' ',' '],
    [' ',' ','A','V','A','V','A','V',' ',' '],
    [' ',' ','V','A',' ',' ','V','A',' ',' '],
    [' ',' ','A','V',' ',' ','A','V',' ',' '],
    [' ',' ','V','A','V','A','V','A',' ',' '],
    [' ',' ','A','V','A','V','A','V',' ',' '],
    [' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],
    [' ',' ',' ',' ',' ',' ',' ',' ',' ',' ']
]).

init_player('V').

init_game(Board,Player):-
    init_board(Board),
	init_player(Player).

% player vs player --------------------------------------------------------

game_pvp(Board, Player):-
    display_game(Board, Player),
    get_new_play_cell(Col, Row),
    verify_owner(Board, Col, Row, Player),
    get_checker_points(Board, Col, Row, Points),
    get_new_play_move(Move),
    verify_move_choice(Board, Player, Move),
    get_cell_after_move(Col, Row, Move, Mcol, Mrow),
    verify_available(Board, Mcol, Mrow),
    get_newBoard(Board, Player, Col, Row, Mcol, Mrow, NewBoard),
    get_checker_points(NewBoard, Mcol, Mrow, NewPoints),
    Points < NewPoints,
    change_player(Player, Next),
    game_pvp(NewBoard, Next).

game_pvp(Board, Player):-
    not_valid, nl,nl,
    game_pvp(Board, Player).





