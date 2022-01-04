print_n(_, 0).
print_n(S, N) :- 
    write(S),
    N1 is N-1,
    print_n(S, N1).

write_text([], 0).
write_text([H|T], Len) :-
    put_code(H),
    L1 is Len-1,
    write_text(T, L1).

print_text(Text, Symbol, Padding) :-
    write(Symbol),
    print_n(' ', Padding),
    length(Text, Len),
    write_text(Text, Len),
    print_n(' ', Padding),
    write(Symbol).

print_banner(Text, Symbol, Padding) :-
    length(Text, Len),
    print_n(Symbol, Len + Padding*2 + 2),nl,
    write(Symbol), print_n(' ', Len + Padding*2), write(Symbol),nl,
    print_text(Text, Symbol, Padding),nl,
    write(Symbol), print_n(' ', Len + Padding*2), write(Symbol),nl,
    print_n(Symbol, Len + Padding*2 + 2).
