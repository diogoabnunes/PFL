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
    read_number_acc(0, X), !,
    get_code(10).