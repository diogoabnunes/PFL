:- dynamic flight/6, destiny/1, number_destiny/2.

/* flight(origin, destination, company, code, hour, duration) */
flight(porto, lisbon, tap, tp1949, 1615, 60). 
flight(lisbon, madrid, tap, tp1018, 1805, 75). 
flight(lisbon, paris, tap, tp440, 1810, 150). 
flight(lisbon, london, tap, tp1366, 1955, 165). 
flight(london, lisbon, tap, tp1361, 1630, 160). 
flight(porto, madrid, iberia, ib3095, 1640, 80). 
flight(madrid, porto, iberia, ib3094, 1545, 80). 
flight(madrid, lisbon, iberia, ib3106, 1945, 80). 
flight(madrid, paris, iberia, ib3444, 1640, 125). 
flight(madrid, london, iberia, ib3166, 1550, 145). 
flight(london, madrid, iberia, ib3163, 1030, 140). 
flight(porto, frankfurt, lufthansa, lh1177, 1230, 165).

/* Lista com todos os aeroportos na base de dados sem duplicados */
get_all_nodes(L) :-
    setof(Orig, Dest^Comp^Code^Hour^Dur^flight(Orig,Dest,Comp,Code,Hour,Dur),L).

/* Operadora com número de destinos mais diversificados */
company_flights(Company, Len) :-
    findall(Company, flight(_,_,Company,_,_,_), L),
    length(L, Len).

get_most_common(L,Company) :- get_most_common(L,0,_C,Company).

get_most_common([],_,Comp,Comp) :- !.
get_most_common([C-N|T], Num, Acc, Comp) :- 
    (N > Num -> 
        get_most_common(T,N,C,Comp) ; get_most_common(T,Num,Acc,Comp)).

most_diversified(Company) :-
    setof(Comp-N, Dest^Orig^Code^Hour^Dur^(flight(Orig,Dest,Comp,Code,Hour,Dur), company_flights(Comp,N)),L),
    get_most_common(L,Company).

/* Lista com 1+ (códigos de) voos que permitam ligar Origin a Destination. 
   Pesquisa em profundidade, evitando ciclos */
% find_flights(Origin, Destination, Flights).

/* Lista com 1+ (códigos de) voos que permitam ligar Origin a Destination. 
   Pesquisa em largura, evitando ciclos */
% find_flights_breadth(Origin, Destination, Flights).