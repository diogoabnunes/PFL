:- [logic].
:- [utils].

play :- 
    repeat, 
    display_game_name,
    menu_game_mode, nl,
    read_number(Choice),
    Choice < 4,
    start(Choice).

% game modes ---------------------------------------------
start(Choice) :- 
    Choice == 1, !,
    init_game(Board,Player),
    game_pvp(Board, Player).

start(Choice) :- 
    Choice == 2, !, 
    init_game(Board,Player),
    game_pvc(Board, Player).

start(Choice) :-
    Choice == 3, !,
    init_game(Board,Player),
    game_cvc(Board, Player).

start(Choice) :-
    Choice == 4,
    abort.

start(_) :-
    nl, write('--INVALID INPUT--'), nl,
    play.

