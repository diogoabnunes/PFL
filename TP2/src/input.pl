
:- [menu].

get_new_play(IntCol, IntRow, Move):-
    write('Column: '), nl,
    read(Col),
    IntCol is Col - 1,
    write('Row: '), nl,
    read(Row),
    IntRow is Row - 1,
    menu_play_moves,
    read(Move).
