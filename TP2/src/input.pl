
:- [menu].

code_col('a', 0).
code_col('b', 1).
code_col('c', 2).
code_col('d', 3).
code_col('e', 4).
code_col('f', 5).
code_col('g', 6).
code_col('h', 7).
code_col('i', 8).
code_col('j', 9).

get_new_play_cell(IntCol, IntRow):-
    write('Column: '), nl,
    read(Col),
    verify_col_choice(Col),
    code_col(Col, IntCol),
    write('Row: '), nl,
    read(Row),
    verify_row_choice(Row),
    IntRow is Row - 1.

get_new_play_move(Move):-
    menu_play_moves,
    read(Move),
    verify_move_choice(Move).


%verify_move_choice(+Move):-
verify_move_choice(Move):-
   ( Move == 1; 
    Move == 2; 
    Move == 3; 
    Move == 4) .

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