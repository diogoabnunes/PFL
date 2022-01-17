leciona(algoritmos, adalberto).
leciona(bases_de_dados, bernardete).
leciona(compiladores, capitolino).
leciona(estatistica, diogenes).
leciona(redes, ermelinda).

frequenta(algoritmos, alberto).
frequenta(algoritmos, bruna).
frequenta(algoritmos, cristina).
frequenta(algoritmos, diogo).
frequenta(algoritmos, eduarda).

frequenta(bases_de_dados, antonio).
frequenta(bases_de_dados, bruno).
frequenta(bases_de_dados, cristina).
frequenta(bases_de_dados, duarte).
frequenta(bases_de_dados, eduardo).

frequenta(compiladores, alberto).
frequenta(compiladores, bernardo).
frequenta(compiladores, clara).
frequenta(compiladores, diana).
frequenta(compiladores, eurico).

frequenta(estatistica, antonio).
frequenta(estatistica, bruna).
frequenta(estatistica, claudio).
frequenta(estatistica, duarte).
frequenta(estatistica, eva).

frequenta(redes, alvaro).
frequenta(redes, beatriz).
frequenta(redes, claudio).
frequenta(redes, diana).
frequenta(redes, eduardo).

aluno(X, Y) :-
    frequenta(UC, X),
    leciona(UC, Y).

colega(X, Y, UC) :-
    frequenta(UC, X),
    frequenta(UC, Y),
    X \= Y.

teachers(T) :- setof(Prof, Uc^leciona(Uc, Prof), T).

students_of(T, S) :- setof(Stud, aluno(Stud, T), S).

teachers_of(S, T) :- setof(Prof, aluno(S, Prof), T).

common_courses(S1, S2, C) :- setof(UC, (frequenta(UC, S1), frequenta(UC, S2)), C).

more_than_one_course(L) :- 
    setof(Stud, (UC1, UC2)^(frequenta(UC1, Stud), frequenta(UC2, Stud), UC1 \= UC2), L).

strangers(X, Y) :- \+ colega(X, Y), X \= Y.
strangers(L) :-
    setof(S1-S2, (UC1, UC2)^(aluno(S1, UC1), aluno(S2, UC2), strangers(S1, S2)), L).

good_groups(L) :-
    setof(S1-S2, (UC1, UC2)^(frequenta(UC1, S1), frequenta(UC2, S1),
                             frequenta(UC1, S2), frequenta(UC2, S2),
                             UC1 \= UC2, S1 \= S2), L).
