     
menu_game_mode :-
	nl,write('Choose the game mode: '),nl,nl,
	write('1. Player 1 vs. Player 2'),nl,
	write('2. Player vs. Computer'),nl,
	write('3. Computer vs. Player'),nl,
	write('4. Computer 1 vs. Computer 2'),nl,
	write('5. Quit').

menu_play_moves :-
	nl,write('Choose the next move: '),nl,
	write('1. Right  2. Left  3. Up  4. Down'),nl,
	write('5. Another cell'),nl.