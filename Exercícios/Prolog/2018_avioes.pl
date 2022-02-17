%airport(Name, ICAO, Country).
airport('Aeroporto Franscisco Sa Carneiro', 'LPPR', 'Portugal').
airport('Aeroporto Humberto Delgado', 'LPPT', 'Portugal').
airport('Aeroporto Adolfo Suárez Madrid-Barajas', 'LEMD', 'Spain').
airport('Aeroporto de Paris-Charles-de-Gaulle Roissy Airport', 'LFPG', 'France').
airport('Aeroporto Internazionale di Roma-Fiumicino - Leonardo da Vinci', 'LIRF', 'Italy').

%company(ICAO,Name , Year, Country)
company('TAP', 'Tap Air Portugal', 1945, 'Portugal').
company('RYR', 'Ryanair', 1984, 'Ireland').
company('AFR', 'Société Air France, S.A', 1933, 'France').
company('BAW', 'British Airways', 1974, 'United Kingdom').

%flight(Designation, Origin , Destination, DepartureTime, Duration, Company)
flight('TP1923', 'LPPR', 'LPPT', 1115, 55, 'TAP').
flight('TP1968', 'LPPT', 'LPPR', 2235, 55, 'TAP').
flight('TP842', 'LPPT', 'LIRF', 1450, 195, 'TAP').
flight('TP843', 'LIRF', 'LPPT', 1935, 195, 'TAP').
flight('FR5483', 'LPPR', 'LEMD', 630, 105, 'RYR').
flight('FR5484', 'LEMD', 'LPPR', 1935, 105, 'RYR').
flight('AF1024', 'LFPG', 'LPPT', 940, 155, 'AFR').
flight('AF1025', 'LPPT', 'LFPG', 1310, 155, 'AFR').

% -----------------------------------------------------------------------------------------

%short(+Flight)
short(Flight) :-
    flight(Flight, _, _, _, Duration, _),
    Duration < 90.

% -----------------------------------------------------------------------------------------

%shorter(+Flight1, +Flight2, -ShorterFlight)
shorter(Flight1, Flight2, Flight1) :-
    flight(Flight1, _, _, _, Duration1, _),
    flight(Flight2, _, _, _, Duration2, _),
    Duration1 < Duration2.
shorter(Flight1, Flight2, Flight2) :-
    flight(Flight1, _, _, _, Duration1, _),
    flight(Flight2, _, _, _, Duration2, _),
    Duration1 > Duration2.

% -----------------------------------------------------------------------------------------

%arrivalTime(+Flight, -ArrivalTime)
arrivalTime(Flight, ArrivalTime) :-
    flight(Flight, _, _, Departure, Duration, _),
    DepartureMinutes is Departure mod 100,
    Minutes is DepartureMinutes + Duration,
    Arrival is (Departure // 100 + Minutes // 60) * 100 + Minutes mod 60,
    ArrivalTime is Arrival mod 2400.

% -----------------------------------------------------------------------------------------

my_member( X, [X|_] ).
my_member( X, [_|T] ):-
    my_member(X, T).

operates(Company, Country) :-
    company(Company, _, _, _),
    flight(_, Origin, _, _, _, Company),
    airport(_, Origin, Country).
operates(Company, Country) :-
    company(Company, _, _, _),
    flight(_, _, Destination, _, _, Company),
    airport(_, Destination, Country).

%countries(+Company, -ListOfCountries)
countries(Company, ListOfCountries) :-
    countries(Company, [], ListOfCountries), !.

countries(Company, Acc, ListOfCountries) :-
    operates(Company, Country),
    \+ my_member(Country, Acc),
    countries(Company, [Country|Acc], ListOfCountries).
countries(_, ListOfCountries, ListOfCountries).

% -----------------------------------------------------------------------------------------

toMinutes(Time, Minutes) :-
    Minutes is (Time // 100) * 60 + Time mod 100.

timeDiff(Time1, Time2, DiffMinutes) :-
    toMinutes(Time1, Minutes1), toMinutes(Time2, Minutes2),
    DiffMinutes is Minutes1 - Minutes2, DiffMinutes > 0, !.

timeDiff(Time1, Time2, DiffMinutes) :-
    toMinutes(Time1, Minutes1), toMinutes(Time2, Minutes2),
    DiffMinutes is Minutes1 - Minutes2 + 2400.

%pairableFlights
pairableFlights :-
    flight(Flight1, _, Destination1, _, _, _),
    flight(Flight2, Origin2, _, Departure2, _, _),
    Destination1 == Origin2,
    arrivalTime(Flight1, Arrival1),
    timeDiff(Departure2, Arrival1, Diff),
    Diff >= 30, Diff =< 90,
    format('~w - ~w \\ ~w', [Origin2, Flight1, Flight2]), nl,
    fail.
pairableFlights.

% -----------------------------------------------------------------------------------------

%tripDays(+Trip, +Time, -FlightTimes, -Days)
tripDays([Destination], _, [], 1):-
	airport(_, _, Destination).

tripDays([TripHead, Destination | TripTail], Time, [FlightTimesHead | FlightTimesTail], Days):-
	airport(_, Airport, TripHead),
	airport(_, Airport2, Destination),
	flight(Flight, Airport, Airport2, FlightTimesHead, _, _),
	arrivalTime(Flight, ArrivalTime),
    FlightTimesHead > Time,
    tripDays([Destination | TripTail], ArrivalTime, FlightTimesTail, Days),
    !.

tripDays([TripHead, Destination | TripTail], Time, [FlightTimesHead | FlightTimesTail], Days):-
	airport(_, Airport, TripHead),
	airport(_, Airport2, Destination),
	flight(Flight, Airport, Airport2, FlightTimesHead, _, _),
	arrivalTime(Flight, ArrivalTime),
	FlightTimesHead < Time,
    tripDays([Destination | TripTail], ArrivalTime, FlightTimesTail, TempDays),
    Days is TempDays + 1,
	!.

% -----------------------------------------------------------------------------------------

:- use_module(library(lists)).

%avgFlightLengthFromAirport(+Airport, -AvgLength)
avgFlightLengthFromAirport(Airport, AvgLength) :-
    findall(Duration, flight(_, Airport, _, _, Duration, _), Durations),
    length(Durations, Len),
    sumlist(Durations, Acc),
    AvgLength is Acc/Len.

% -----------------------------------------------------------------------------------------

%mostInternational(-ListOfCompanies)
mostInternational(ListOfCompanies) :-
    setof(
        Count, (
            company(C, _, _, _), countries(C, CompanyCountries), length(CompanyCountries, Count)
        ),
        Counts
    ),
    max_member(MaxCount, Counts),
    findall(
        Company, (
            company(Company, _, _, _), countries(Company, Countries), length(Countries, MaxCount)
        ),
        ListOfCompanies
    ), !.

% -----------------------------------------------------------------------------------------