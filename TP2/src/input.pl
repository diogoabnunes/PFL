:- [menu].

code('a', 0).
code('b', 1).
code('c', 2).
code('d', 3).
code('e', 4).
code('f', 5).
code('g', 6).
code('h', 7).
code('i', 8).
code('j', 9).

get_new_play_cell(IntCol, IntRow):-
    write('Column (a-j): '), nl,
    read(Col),
    verify_col_choice(Col),
    code(Col, IntCol),
    write('Row (1-10): '), nl,
    read(Row),
    verify_row_choice(Row),
    IntRow is Row - 1.

get_new_play_move(Move, Board, Player):-
    menu_play_moves,nl,
    read(Move),
    verify_move_choice(Move, Board, Player).

%verify_move_choice(+Move, +Board, +Player):-
verify_move_choice(1, _, _).
verify_move_choice(2, _, _).
verify_move_choice(3, _, _).
verify_move_choice(4, _, _).

verify_move_choice(0, Board, Player) :-
    end_the_game(Board, Player, []).

%verify_row_choice(+Row):-
verify_row_choice(Row):-
   (Row == 1; 
    Row == 2; 
    Row == 3; 
    Row == 4; 
    Row == 5; 
    Row == 6; 
    Row == 7; 
    Row == 8; 
    Row == 9;
    Row == 10) .

%verify_col_choice(+Cell):-
verify_col_choice(Col):-
   (Col == 'a'; 
    Col == 'b'; 
    Col == 'c'; 
    Col == 'd'; 
    Col == 'e'; 
    Col == 'f'; 
    Col == 'g'; 
    Col == 'h'; 
    Col == 'i';
    Col == 'j') .