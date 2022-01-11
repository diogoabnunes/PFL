print_n(_, 0).
print_n(S, N) :- 
    N1 is N-1,
    write(S),
    print_n(S, N1).

print_string("").
print_string([H|T]) :-
    char_code(Char, H),
    write(Char),
    print_string(T).

print_text(Text, Symbol, Padding) :-
    write(Symbol),
    print_n(' ', Padding),
    print_string(Text),
    print_n(' ', Padding),
    write(Symbol).

print_banner(Text, Symbol, Padding) :-
    length(Text, Len),
    print_n(Symbol, Len + Padding*2 + 2),nl,
    write(Symbol), print_n(' ', Len + Padding*2), write(Symbol),nl,
    print_text(Text, Symbol, Padding),nl,
    write(Symbol), print_n(' ', Len + Padding*2), write(Symbol),nl,
    print_n(Symbol, Len + Padding*2 + 2).

read_number_acc(X, X) :-
    peek_code(10), !.
read_number_acc(Acc, X) :-
    get_code(Code),
    char_code('0', Zero),
    Digit is Code-Zero,
    Digit >= 0, Digit < 10,
    NewAcc is Acc*10 + Digit,
    read_number_acc(NewAcc, X).

read_number(X) :- 
    read_number_acc(0, X),
    get_code(10).

read_until_between(Min, Max, Value) :-
    repeat,
    write('Write a number between '), write(Min), write(' and '), write(Max), write(':'),
    read_number(Value),
    Value >= Min, Value =< Max, !.

read_string("") :- 
    peek_code(10), !,
    get_code(_).
read_string([Char | T]) :-
    get_code(Char),
    read_string(T).

banner :-
    write('Text: '), read_string(Text),
    write('Symbol: '), get_char(Symbol), get_char(_),
    write('Padding: '), read_number(Padding),
    write('Banner!'), nl,
    print_banner(Text, Symbol, Padding).

adjust_alignment(Text, Size, Text) :-
    length(Text, TextSize),
    0 is (Size - TextSize) mod 2.
adjust_alignment(Text, Size, [32 | Text]) :- /* 32 is Space ASCII code */
    length(Text, TextSize),
    1 is (Size - TextSize) mod 2. 

print_texts([], _, _, _).
print_texts([Text | T], Size, Symbol, Padding) :-
    adjust_alignment(Text, Size, EffectiveText),
    length(Text, TextSize),
    EffectivePadding is Padding + (Size - TextSize) div 2,
    print_text(EffectiveText, Symbol, EffectivePadding), nl,
    print_texts(T, Size, Symbol, Padding).

biggest([], []).
biggest([Biggest | T], Biggest) :-
    length(Biggest, BiggestLen),
    biggest(T, SecondBiggest),
    length(SecondBiggest, SecondBiggestLen),
    SecondBiggestLen =< BiggestLen,
    !.
biggest([_ | T], Biggest) :- biggest(T, Biggest).

print_multi_banner(Texts, Symbol, Padding) :-
    Padding >= 0,
    biggest(Texts, BiggestText),
    length(BiggestText, TextSize),
    print_n(Symbol, TextSize + Padding*2 + 2),nl,
    write(Symbol), print_n(' ', TextSize + Padding*2), write(Symbol),nl,
    print_texts(Texts, TextSize, Symbol, Padding),
    write(Symbol), print_n(' ', TextSize + Padding*2), write(Symbol),nl,
    print_n(Symbol, TextSize + Padding*2 + 2).

oh_christmas_tree(N) :- oh_christmas_tree(0, N).

repeat(0, _, []).
repeat(N, Elem, [Elem | T]) :-
    N > 0, N1 is N-1,
    repeat(N1, Elem, T).

oh_christmas_tree(Acc, N) :-
    Acc is N,
    print_text("*", '', N), !.

oh_christmas_tree(Acc, N) :-
    char_code('*', Asterisk),
    NLeaves is Acc*2,
    repeat(NLeaves, Asterisk, Leaves),
    append(Leaves, [Asterisk], Section),
    Padding is N-Acc,
    print_text(Section, '', Padding), nl,
    NewAcc is Acc+1,
    oh_christmas_tree(NewAcc, N).