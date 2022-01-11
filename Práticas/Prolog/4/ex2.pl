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
get_airports :-
    flight(A, B, _, _, _, _),
    assert(airport(A)),
    assert(airport(B)).

get_all_nodes(ListOfAirports) :-
    get_airports, !,
    setof(Airport, airport(Airport), ListOfAirports).

/* Operadora com número de destinos mais diversificados */


most_diversified(Company) :-
    

/* Lista com 1+ (códigos de) voos que permitam ligar Origin a Destination. 
   Pesquisa em profundidade, evitando ciclos */
% find_flights(Origin, Destination, Flights).

/* Lista com 1+ (códigos de) voos que permitam ligar Origin a Destination. 
   Pesquisa em largura, evitando ciclos */
% find_flights_breadth(Origin, Destination, Flights).