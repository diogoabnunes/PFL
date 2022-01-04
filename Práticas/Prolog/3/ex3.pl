immature(X) :- adult(X), !, fail. 
immature(X).
/* Red Cut, porque o ! influencia os resultados */

adult(X) :- person(X), !, age(X, N), N >=18. 
adult(X) :- turtle(X), !, age(X, N), N >=50. 
adult(X) :- spider(X), !, age(X, N), N>=1. 
adult(X) :- bat(X), !, age(X, N), N >=5.
/* Green Cut, porque o ! não influencia os resultados, apenas é usado para aumentar a eficiência */