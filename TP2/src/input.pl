
:- [menu].

get_new_play_cell(IntCol, IntRow):-
    write('Column: '), nl,
    read(Col),
    verify_Cell_choice(Col),
    IntCol is Col - 1,
    write('Row: '), nl,
    read(Row),
    verify_Cell_choice(Row),
    IntRow is Row - 1.

get_new_play_move(Move):-
    menu_play_moves,
    read(Move),
    verify_move_choice(Move).


%verify_move_choice(+Move):-
verify_move_choice(Move):-
   ( Move == 1 ; 
    Move == 2; 
    Move == 3; 
    Move == 4) .

%verify_Cell_choice(+Cell):-
verify_Cell_choice(Cell):-
   (Cell == 1 ; 
    Cell == 2; 
    Cell == 3; 
    Cell == 4; 
    Cell == 5; 
    Cell == 6; 
    Cell == 7; 
    Cell == 8; 
    Cell == 9;
    Cell == 10) .