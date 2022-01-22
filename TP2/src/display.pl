clear :- write('\33\[2J').

begin_state([
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

mid_state([
    [0,0,0,0,0,0,0,0,0,0],
    [0,0,0,0,0,0,0,0,0,0],
    [0,0,V,V,A,V,A,A,0,0],
    [0,0,A,A,A,V,V,0,0,0],
    [0,0,A,V,0,0,V,0,A,0],
    [0,A,V,V,V,A,V,V,0,0],
    [0,0,V,0,0,A,0,A,0,0],
    [0,A,V,A,A,A,0,0,0,0],
    [0,0,0,0,0,V,0,V,0,0],
    [0,0,0,0,0,0,0,0,0,0]
]).


display_game_name :- nl,
	write('                       _______                              '), nl,
	write('                          |   ___    ___  __|__  |   ___      '), nl,    
	write('                          |  /   \\  /___    |    |  /___|     '), nl,
	write('                      \\___/  \\___/   ___/   |    |  \\___      '), nl,
	nl.

display_game_over :-
	write('             ____                                ___                        '), nl,
	write('            /        __     __  __    ___       /   \\          ___     __   '), nl,    
	write('           |   __    __|  |/  |/  |  /___|     |     |  \\  /  /___|  |/     '), nl,
	write('            \\____|  |__|  |   |   |  \\___       \\___/    \\/   \\___   |      '), nl,
	nl.

display_player(Player):-
	format('     Player: ~w', Player), nl, nl, nl. 

display_winner(Player):-
	nl, format('                               WINNER: Player ~w ', Player), nl, nl, nl.


%display_board(+Board)
display_board(Board):-
   	printColumnIdentifiers, nl,
    printHorizontalSeparator, nl,
	print_matrix(Board).

printColumnIdentifiers:-
	write('                                a b c d e f g h i j').

printHorizontalSeparator:-
	write('                                ___________________ ').

print_matrix(Board):-
    print_matrix(Board,1).

print_matrix([],_).

print_matrix([H|T], N) :-
    print_line(H, N), nl,
    N1 is N+1,
    print_matrix(T, N1).

print_line(H, X) :-
	printRowId(X),
    format(' |~w|~w|~w|~w|~w|~w|~w|~w|~w|~w|', H).

printRowId(X):-
    X > 9, !,     
    format('                            ~w', X).

printRowId(X):- 
    format('                             ~w', X).

%display_game(+GameState) 
display_game(Board-Player) :-
    nl,nl,
    write('---------------------------------------------------------------'),nl,
 	display_board(Board), 	
    display_player(Player).


% messages ----------------------------------------------------------------
not_implemented :-
    nl, write('--This mode is not available yet--'),
	abort.

valid :-
    nl, write('--VALID--').

not_valid :-
    nl, write('--NOT VALID, TRY AGAIN--').
