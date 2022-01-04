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
    veriify_owner(Board, Col, Row, Player),
    get_new_play_move(Move),
    veriify_move_choice(Board, Player, Move),
    get_cell_after_move(Col, Row, Move, Mcol, Mrow),
    get_newBoard(Board, Player, Col, Row, Mcol, Mrow, NewBoard),
    change_player(Player, Next),
    game_pvp(NewBoard, Next).

game_pvp(Board, Player):-
    not_valid, nl,nl,
    game_pvp(Board, Player).





