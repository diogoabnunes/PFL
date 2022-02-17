%player(Name, UserName, Age).
player('Danny', 'Best Player Ever', 27).
player('Annie', 'Worst Player Ever', 24).
player('Harry', 'A-Star Player', 26).
player('Manny', 'The Player', 14).
player('Jonny', 'A Player', 16).

%game(Name, Categories, MinAge).
game('5 ATG', [action, adventure, open-world, multiplayer], 18).
game('Carrier Shift: Game Over', [action, fps, multiplayer, shooter], 16).
game('Duas Botas', [action, free, strategy, moba], 12).

:-dynamic played/4.
%played(Player, Game, HoursPlayed, PercentUnlocked)
played('Best Player Ever', '5 ATG', 3, 83).
played('Worst Player Ever', '5 ATG', 52, 9).
played('The Player', 'Carrier Shift: Game Over', 44, 22).
played('A Player', 'Carrier Shift: Game Over', 48, 24).
played('A-Star Player', 'Duas Botas', 37, 16).
played('Best Player Ever', 'Duas Botas', 33, 22).

% -----------------------------------------------------------------------------------------

%achievedALot(+Player)
achievedALot(Player) :-
    played(Player, _, _, Percentage),
    Percentage >= 80.

% -----------------------------------------------------------------------------------------

%isAgeAppropriate(+Name, +Game)
isAgeAppropriate(Name, Game) :-
    player(Name, _, Age),
    game(Game, _, MinAge),
    MinAge =< Age.

% -----------------------------------------------------------------------------------------

timePlayed(Player, Game, Time) :-
    played(Player, Game, Time, _), !.
timePlayed(_, _, 0).

%timePlayingGames(+Player, +Games, -ListOfTimes, -SumTimes)
timePlayingGames(_, [], [], 0).
timePlayingGames(Player, [H_Games|T_Games], [H_Times|T_Times], SumTimes) :-
    timePlayed(Player, H_Games, H_Times),
    timePlayingGames(Player, T_Games, T_Times, T_SumTimes),
    SumTimes is H_Times + T_SumTimes.

% -----------------------------------------------------------------------------------------

my_member( X, [X|_] ).
my_member( X, [_|T] ):- my_member(X, T).

%listGamesOfCategory(+Cat)
listGamesOfCategory(Cat) :-
    game(Name, Categories, MinAge),
    my_member(Cat, Categories),
    format('~w (~d)\n', [Name, MinAge]),
    fail.
listGamesOfCategory(_).

% -----------------------------------------------------------------------------------------

%updatePlayer(+Player, +Game, +Hours, +Percentage)
updatePlayer(Player, Game, Hours, Percentage) :-
    played(Player, Game, OldHours, OldPercentage),
    NewHours is OldHours + Hours,
    NewPercentage is OldPercentage + Percentage,
    retract(played(Player, Game, _, _)),
    assert(played(Player, Game, NewHours, NewPercentage)).

% -----------------------------------------------------------------------------------------

%fewHours(+Player, -Games)
fewHours(Player, Games) :- fewHours(Player, [], Games).

fewHours(Player, Helper, Games) :-
    played(Player, Game, Hours, _),
    Hours < 10,
    \+ my_member(Game, Helper), !,
    fewHours(Player, [Game|Helper], Games).
fewHours(_, Games, Games).

% -----------------------------------------------------------------------------------------

:- use_module(library(lists)).

%ageRange(+MinAge, +MaxAge, -Players)
ageRange(MinAge, MaxAge, Players) :- 
    findall(
        Player, (
            player(Player, _, Age),
            Age >= MinAge,
            Age =< MaxAge
        ),
        Players
    ).

% -----------------------------------------------------------------------------------------

%averageAge(+Game, -AverageAge)
averageAge(Game, AverageAge) :-
    findall(
        Age, (
            player(_, Player, Age),
            played(Player, Game, _, _)
        ),
        Ages
    ),
    sumlist(Ages, Count),
    length(Ages, Len),
    AverageAge is Count/Len.

% -----------------------------------------------------------------------------------------

getMaxEfficiency(Game, MaxEfficiency) :-
    findall(
        Efficiency, (
            played(_, Game, Hours, Percentage),
            Efficiency is Percentage / Hours
        ),
        Efficiencies
    ),
    max_member(MaxEfficiency, Efficiencies).

getPlayersWithMaxEfficiency(Game, MaxEfficiency, Players) :-
    findall(
        Player, (
            played(Player, Game, Hours, Percentage),
            MaxEfficiency =:= Percentage / Hours
        ),
        Players
    ).

%mostEffectivePlayers(+Game, -Players)
mostEffectivePlayers(Game, Players) :-
    getMaxEfficiency(Game, MaxEfficiency),
    getPlayersWithMaxEfficiency(Game, MaxEfficiency, Players).

% -----------------------------------------------------------------------------------------

whatDoesItDo(X) :-
    player(Y, X, Z), !,
    \+ ( played(X, G, L, M),
            game(G, N, W),
            W > Z ).

someName(Player) :-
    player(_, Player, Age), !,
    \+ (
        played(Player, Game, _, _),
        game(Game, _, MinAge),
        MinAge > Age
    ).

/*
O predicado determina se um Player não joga nenhum jogo desadequado à sua idade.
O cut usado serve apenas para melhorar o desempenho, porque a sua remoção não afeta o resultado obtido. Sem o cut, o interpretador estaria à procura de outras soluções possíveis que sabemos de antemão que não existem.
*/

