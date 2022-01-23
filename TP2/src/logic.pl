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

end_state([
    [' ',' ',' ',' ',' ',' ',' ',' ',' ',' '],
    [' ',' ','V',' ',' ','V',' ',' ',' ',' '],
    [' ',' ','V',' ','A',' ','A','A',' ',' '],
    [' ','A',' ','A','A','V','V',' ',' ',' '],
    [' ','A',' ',' ',' ','V','V',' ','A',' '],
    [' ','A','V','V','V','A','V','V',' ',' '],
    [' ','A','V',' ',' ','A','A',' ',' ',' '],
    [' ',' ','V','A','A','A',' ',' ',' ',' '],
    [' ',' ',' ',' ',' ','V','V',' ',' ',' '],
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
    get_new_play_move(Move),
    get_cell_after_move(Col, Row, Move, Mcol, Mrow),
    verify_available(Board, Mcol, Mrow),
    get_newBoard(Board, Player, Col, Row, Mcol, Mrow, NewBoard),
    get_checker_points(Board, Col, Row, Points),
    get_checker_points(NewBoard, Mcol, Mrow, NewPoints),
    Points < NewPoints,
    change_player(Player, Next),
    verify_end_game(NewBoard, Next),
    game_pvp(NewBoard, Next).

game_pvp(Board, Player):-
    not_valid, nl,nl,
    game_pvp(Board, Player).

% player vs computer --------------------------------------------------------
game_pvc(Board, Player):-
    Player == 'V',
    display_game(Board, Player),
    get_new_play_cell(Col, Row),
    verify_owner(Board, Col, Row, Player),
    get_new_play_move(Move),
    get_cell_after_move(Col, Row, Move, Mcol, Mrow),
    verify_available(Board, Mcol, Mrow),
    get_newBoard(Board, Player, Col, Row, Mcol, Mrow, NewBoard),
    get_checker_points(Board, Col, Row, Points),
    get_checker_points(NewBoard, Mcol, Mrow, NewPoints),
    Points < NewPoints,
    change_player(Player, Next),
    verify_end_game(NewBoard, Next),
    game_pvc(NewBoard, Next).

game_pvc(Board, Player):-
    Player == 'A',
    display_game(Board, Player),
    get_computer_plays(Board, Player, [Col, Row, Move]),
    get_cell_after_move(Col, Row, Move, Mcol, Mrow),
    get_newBoard(Board, Player, Col, Row, Mcol, Mrow, NewBoard),
    change_player(Player, Next),
    verify_end_game(NewBoard, Next),
    game_pvc(NewBoard, Next).

game_pvc(Board, Player):-
    not_valid, nl,nl,
    game_pvc(Board, Player).

% computer vs computer --------------------------------------------------------
game_cvc(Board, Player):-
    display_game(Board, Player),
    get_computer_plays(Board, Player, [Col, Row, Move]),
    display_play(Col, Row, Move),
    get_cell_after_move(Col, Row, Move, Mcol, Mrow),
    get_newBoard(Board, Player, Col, Row, Mcol, Mrow, NewBoard),
    change_player(Player, Next),
    verify_end_game(NewBoard, Next),
    game_cvc(NewBoard, Next).

game_cvc(Board, Player):-
    not_valid, nl,nl,
    game_cvc(Board, Player).

% general ----------------------------------------------------------------------

verify_end_game(Board, Player):-
    get_valid_plays(Board, Player, Plays), 
    end_the_game(Board, Player, Plays).

end_the_game(Board, Player, []):-
    display_board(Board),
    display_game_name,
    display_game_over,
    change_player(Player, Winner),
    display_winner(Winner),
    abort.

end_the_game(_, _, _).
    




