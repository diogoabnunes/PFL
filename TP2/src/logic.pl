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
    get_new_play(Col, Row, Move),
    veriify_owner(Board, Col, Row, Player),
    veriify_move_choice(Board, Player, Move),
    get_cell_after_move(Col, Row, Move, Mcol, Mrow),
    get_newBoard(Board, Player, Col, Row, Mcol, Mrow, NewBoard),
    change_player(Player, Next),
    game_pvp(NewBoard, Next).
    

%veriify_owner(+Board, +Col, +Row, +Player)
veriify_owner(Board, Col, Row, Player) :-
    get_cell_value(Board, Col, Row, Value),   
    Value == Player,!.

veriify_owner(Board, _, _, Player) :-
    write('--not a valid cell, try again--'), nl,
    game_pvp(Board, Player).


%veriify_move_choice(+Board, +Player, +Move):-
veriify_move_choice(_, _, Move):-
   ( Move == 1 ; 
    Move == 2; 
    Move == 3; 
    Move == 4) ,!.

veriify_move_choice(Board, Player, Move):-
    Move == 5, !,nl, 
    game_pvp(Board, Player).

veriify_move_choice(Board, Player, _):-
    write('--not a move, try again--'), nl,
    game_pvp(Board, Player).
