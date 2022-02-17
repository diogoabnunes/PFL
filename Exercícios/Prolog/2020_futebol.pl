%jogo(Jornada, EquipaCasa, EquipaVisitante, Resultado)
jogo(1, sporting, porto, 1-2).
jogo(1, maritimo, benfica, 2-0).
jogo(2, sporting, benfica, 0-2).
jogo(2, porto, maritimo, 1-0).
jogo(3, maritimo, sporting, 1-1).
jogo(3, benfica, porto, 0-2).

%treinadores(Equipas, [ [JornadaInicial-JornadaFinal]-NomeTreinador | Lista])
treinadores(porto, [[1-3]-sergio_conceicao]).
treinadores(sporting, [[1-2]-silas, [3-3]-ruben_amorim]).
treinadores(benfica, [[1-3]-bruno_lage]).
treinadores(maritimo, [[1-3]-jose_gomes]).

%--------------------------------------------------------------------------------

%n_treinadores(?Equipa, ?Numero)
n_treinadores(Equipa, Numero) :-
    treinadores(Equipa, Treinadores),
    length(Treinadores, Numero).

%--------------------------------------------------------------------------------

treinador_presente(Treinador, [Jornadas-Treinador|_], Jornadas).
treinador_presente(Treinador, [_|T], Jornadas) :-
    treinador_presente(Treinador, T, Jornadas).

%n_jornadas_treinador(?Treinador, ?NumeroJornadas)
n_jornadas_treinador(Treinador, NumeroJornadas) :-
    treinadores(_, Treinadores),
    treinador_presente(Treinador, Treinadores, [JornFirst-JornLast]),
    NumeroJornadas is JornLast - JornFirst + 1.

%--------------------------------------------------------------------------------

%ganhou(?Jornada, ?EquipaVencedora, ?EquipaDerrotada)
ganhou(Jornada, EquipaVencedora, EquipaDerrotada) :-
    jogo(Jornada, EquipaVencedora, EquipaDerrotada, GolosCasa-GolosFora),
    GolosCasa > GolosFora.
ganhou(Jornada, EquipaVencedora, EquipaDerrotada) :-
    jogo(Jornada, EquipaDerrotada, EquipaVencedora, GolosCasa-GolosFora),
    GolosCasa < GolosFora.

%--------------------------------------------------------------------------------

/*
Qual a forma mais correta de definir o operador "o" em termos sintáticos e semânticos?
*/
:- op(180, fx, o).

/*
Qual a forma mais correta de definir o operador "venceu" em termos sintáticos e semânticos?
*/
:- op(200, xfx, venceu).

o X :- treinadores(X, _).
o X venceu o Y :- ganhou(_, X, Y).

%--------------------------------------------------------------------------------

%predX(?N, +A, +B)
predX(N, N, _).
predX(N, A, B) :-
    !,
    A \= B,
    A1 is A + sign(B-A),
    predX(N, A1, B).

/*
Se enviarmos N, o predicado permite saber que N está dentro de [A,B]. Se N for retornado, N tem o valor de A no início, e permite obter todos os valores até B, sendo a última resposta N = B.
O cut é verde, pois a sua presença não afeta as soluções obtidas pelo predicado, apenas serve para evitar backtracking desnecessário e aumenta a eficiência da pesquisa.
*/

%--------------------------------------------------------------------------------

%treinador_bom(?Treinador)
treinador_bom(Treinador) :-
    treinadores(Equipa, Treinadores),
    treinador_presente(Treinador, Treinadores, [JornFirst-JornLast]), !,
    \+ (
        predX(Jornada, JornFirst, JornLast),
        \+ ganhou(Jornada, Equipa, _)
    ).

%--------------------------------------------------------------------------------

imprime_totobola(1, '1').
imprime_totobola(0, 'X').
imprime_totobola(-1, '2').

imprime_texto(X, 'vitoria da casa'):-
    X = 1.
imprime_texto(X, 'empate'):-
    X = 0.
imprime_texto(X, 'derrota da casa'):-
    X = -1.

%imprime_jogos(+F)
obter_resultado(Jornada, EquipaCasa, EquipaFora, 1):-
    ganhou(Jornada, EquipaCasa, EquipaFora), !.
obter_resultado(Jornada, EquipaCasa, EquipaFora, -1):-
    ganhou(Jornada, EquipaFora, EquipaCasa), !.
obter_resultado(_, _, _, 0):- !.

imprime_jogos(F) :-
    jogo(Jornada, EquipaCasa, EquipaFora, _),
    obter_resultado(Jornada, EquipaCasa, EquipaFora, Resultado),
    format('Jornada ~d: ~s x ~s - ', [Jornada, EquipaCasa, EquipaFora]),
    X =.. [F, Resultado, S],
    X,
    write(S), nl,
    fail.
imprime_jogos(_).

%--------------------------------------------------------------------------------

/*
O predicado imprime_totobola/2 é mais eficiente que imprime_texto/2, pois tira proveito do mecanismo de indexação de predicados do SICStus, que é feito apenas pelo functor e primeiro argumento.
*/

/*
Considere um predicado shutdown/0 que, quando é invocado, faz com que a máquina que está a correr o SICStus Prolog se desligue.
Considere também os predicados =../2 (operador "univ") e imprime_jogos/1, apresentado anteriormente.
Entre os predicados shutdown/0, =../2 e imprime_jogos/1, qual/quais são predicados extra-lógicos?
Apenas shutdown/0 e imprime_jogos/1 são extra-lógicos.
*/

%--------------------------------------------------------------------------------

%lista_treinadores(?L)
lista_treinadores(L) :-
    findall(
        Treinador, (
            treinadores(_, Treinadores),
            treinador_presente(Treinador, Treinadores, _)
        ),
        L
    ), !.

%--------------------------------------------------------------------------------

:- use_module(library(lists)).

%duracao_treinadores(?L)
duracao_treinadores(L) :-
    findall(
        N-Treinador, (
            n_jornadas_treinador(Treinador, N)
        ),
        Treinadores
    ),
    sort(Treinadores, Sorted),
    reverse(Sorted, L), !.

%--------------------------------------------------------------------------------

%pascal(+N, -L)

pascal(1, [1]) :- !.
pascal(N, L) :-
    N1 is N-1,
    pascal(N1, L1),
    append([0], L1, L2),
    append(L2, [0], Aux),
    aux_pascal([], L, Aux), !.

aux_pascal(L, L, [_ | []]).
aux_pascal(Acc, L, [Elem1, Elem2 | Rest]) :-
    NewElem is Elem1 + Elem2,
    append(Acc, [NewElem], NewAcc),
    aux_pascal(NewAcc, L, [Elem2 | Rest]).