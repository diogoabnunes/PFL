
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

get_new_play(IntCol, IntRow, Move):-
    write('Column: '), nl,
    read(ColC),
    code(ColC, IntCol),
    write(IntCol),
    write('Row: '), nl,
    read(Row),
    IntRow is Row - 1,
    menu_play_moves,
    read(Move).

get_new_play_cell(IntCol, IntRow):-
    write('Column: '), nl,
    read(ColC),
    code(ColC, IntCol),
    write(IntCol),
    write('Row: '), nl,
    read(Row),
    IntRow is Row - 1.

get_new_play_move(Move):-
    menu_play_moves,
    read(Move).
