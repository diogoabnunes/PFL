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

/*
i. leciona(UC, diogenes).
ii. leciona(_UC, felismina).
iii. frequenta(UC, claudio).
iv. frequenta(_UC, dalmindo).
v. frequenta(_X, eduarda), leciona(_X, bernardete).
vi. frequenta(_X, alberto), frequenta(_X, alvaro).
*/

aluno(Aluno, Prof) :- 
    frequenta(_UC, Aluno),
    leciona(_UC, Prof).

colega(Aluno1, Aluno2, UC) :-
    frequenta(UC, Aluno1),
    frequenta(UC, Aluno2),
    Aluno1 \= Aluno2.

more_than_one_course(L) :- 
    setof(Stud, (UC1, UC2)^(frequenta(UC1, Stud), frequenta(UC2, Stud), UC1 \= UC2), L).