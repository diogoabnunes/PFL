:- dynamic male/1, female/1, parent/2.

male(frank). male(jay). male(javier).
male(merle). male(phil).
male(mitchell). male(joe).
male(cameron). male(bo).
male(dylan). male(alex).
male(luke). male(rexford).
male(calhoun). male(george).

female(grace). female(dede).
female(gloria). female(barb).
female(claire). female(manny).
female(pameron). female(haley).
female(lily). female(poppy).

parent(grace,phil). parent(frank,phil).
parent(dede,claire). parent(jay,claire).
parent(dede,mitchell). parent(jay,mitchell).
parent(jay,joe). parent(gloria,joe).
parent(gloria,manny). parent(javier,manny).
parent(barb,cameron). parent(merle,cameron).
parent(barb,pameron). parent(merle,pameron).
parent(phil,haley). parent(claire,haley).
parent(phil,alex). parent(claire,alex).
parent(phil,luke). parent(claire,luke).
parent(mitchell,lily). parent(cameron,lily).
parent(mitchell,rexford). parent(cameron,rexford).
parent(pameron,calhoun). parent(bo,calhoun).
parent(dylan,george). parent(haley,george).
parent(dylan,poppy). parent(haley,poppy).

add_person_aux(male, X) :- assert(male(X)).
add_person_aux(female, Y) :- assert(female(Y)).

add_person :-
    write('Insert gender (male or female):'), nl,
    read(Gender),
    write('Insert name:'), nl,
    read(Name),
    add_person_aux(Gender, Name).

add_parents(Person) :-
    write('Parents of '), write(Person), write(':'), nl,
    read(Parent1),
    read(Parent2),
    assert(parent(Parent1, Person)),
    assert(parent(Parent2, Person)).

remove_person :-
    write('Person to remove:'), nl,
    read(Person),
    retractall(male(Person)),
    retractall(parent(Person, _)),
    retractall(parent(_, Person)).