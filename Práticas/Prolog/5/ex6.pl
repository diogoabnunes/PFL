:- use_module(library(lists)).

:- op(400, xfx, exists_in).

exists_in(Element, List) :- member(Element, List).

:- op(450, fx, append).
:- op(500, xfx, results).
:- op(400, xfx, to).

results(append(to(List1, List2)), Result) :-
    append(List2, List1, Result), !.

:- op(450, fx, remove).
:- op(400, xfx, from).

results(remove(from(Elem, List)), Result) :-
    delete(List, Elem, Result).