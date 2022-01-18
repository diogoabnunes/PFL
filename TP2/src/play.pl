:- [logic].
:- [utils].

play :- 
    %repeat, 
    %menu_game_mode, nl,
    %read_number(Choice),
    %Choice < 4,
    %start(Choice).
    start(1).


% game modes ---------------------------------------------
start(Choice) :- 
    Choice == 1, !,
    init_game(Board,Player),
    game_pvp(Board, Player).

start(Choice) :- 
    Choice == 2, !, 
    not_implemented.

start(Choice) :-
    Choice == 3, !,
    not_implemented.

start(Choice) :-
    Choice == 4,
    abort.

start(_) :-
    nl, write('--INVALID INPUT--'), nl,
    play.