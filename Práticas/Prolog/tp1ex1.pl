cls :- write('\33\[2J').

male(frank).
male(jay).
male(javier).
male(merle).
male(phil).
male(mitchell).
male(joe).
male(cameron).
male(bo).
male(dylan).
male(alex).
male(luke).
male(rexford).
male(calhoun).
male(george).

female(grace).
female(dede).
female(gloria).
female(barb).
female(claire).
female(manny).
female(pameron).
female(haley).
female(lily).
female(poppy).

parent(grace,phil).
parent(frank,phil).
parent(dede,claire).
parent(jay,claire).
parent(dede,mitchell).
parent(jay,mitchell).
parent(jay,joe).
parent(gloria,joe).
parent(gloria,manny).
parent(javier,manny).
parent(barb,cameron).
parent(merle,cameron).
parent(barb,pameron).
parent(merle,pameron).
parent(phil,haley).
parent(claire,haley).
parent(phil,alex).
parent(claire,alex).
parent(phil,luke).
parent(claire,luke).
parent(mitchell,lily).
parent(cameron,lily).
parent(mitchell,rexford).
parent(cameron,rexford).
parent(pameron,calhoun).
parent(bo,calhoun).
parent(dylan,george).
parent(haley,george).
parent(dylan,poppy).
parent(haley,poppy).


/*
female(haley).
male(gil).
parent(frank,phil).
parent(X,claire).
parent(gloria,X).
parent(jay,Y),parent(Y,X).
parent(X,Y),parent(Y,lily).
parent(alex,X).
parent(jay,X),\+parent(gloria,X).
*/

father(X,Y) :- parent(X,Y), male(X).
mother(X,Y) :- parent(X,Y), female(X).
grandparent(X,Y) :- father(X,Z), father(Z,Y).
grandmother(X,Y) :- mother(X,Z), mother(Z,Y).

siblings(X,Y) :- 
    parent(A,X), parent(A,Y),
    X \= Y.

halfSiblings(X,Y) :- 
    parent(P1,X), parent(P2,Y),
    parent(P1,Y), \+parent(P2,X).

cousins(X,Y) :-
    siblings(P1,P2),
    parent(P1,X), parent(P2,Y).

uncle(X,Y) :-
    siblings(P1,Y), parent(P1,X).

/*
cousins(haley,lily). -> yes
father(X, luke). -> phil
uncle(X, lily). -> claire,joe,pameron
grandmother(X,_). -> dede,barb,claire
*/

wedding(jay,gloria,2008).
wedding(jay,dede,1968).
divorce(jay,dede,2003).

wedding(X,Y,Z) :-
    wedding(X,Y,DataW),
    Z >= DataW,
    divorce(X,Y,DataD),
    Z < DataD.