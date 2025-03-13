% Generate N empty houses
makehouses(0, []).
makehouses(N, [house(_, _, _, _, _)|List]) :-
    N > 0,
    N1 is N - 1,
    makehouses(N1, List).

% Neighbor relationships
left(X, Y, List) :- nextto(X, Y, List).
right(X, Y, List) :- nextto(Y, X, List).
next_to(X, Y, List) :- left(X, Y, List).
next_to(X, Y, List) :- right(X, Y, List).

% Zebra logic rules
zebra(List) :-
    makehouses(5, List),
    nth1(3, List, house(_, _, _, milk, _)),
    nth1(1, List, house(_, norwegian, _, _, _)),
    member(house(red, englishman, _, _, _), List),
    member(house(_, spaniard, dog, _, _), List),
    member(house(green, _, _, coffee, _), List),
    member(house(_, ukrainian, _, tea, _), List),
    member(house(_, _, snails, _, oldgold), List),
    member(house(yellow, _, _, _, kools), List),
    member(house(_, _, _, orangejuice, luckystrike), List),
    member(house(_, japanese, _, _, parliaments), List),
    right(house(green, _, _, _, _), house(ivory, _, _, _, _), List),
    next_to(house(_, _, _, _, chesterfields), house(_, _, fox, _, _), List),
    next_to(house(_, _, _, _, kools), house(_, _, horse, _, _), List),
    next_to(house(_, norwegian, _, _, _), house(blue, _, _, _, _), List),
    member(house(_, _, zebra, _, _), List),
    member(house(_, _, _, water, _), List).

% Query who owns the zebra
ownsZebra(X) :- zebra(List), member(house(_, X, zebra, _, _), List).

% Query who drinks water
drinksWater(X) :- zebra(List), member(house(_, X, _, water, _), List).

% Measure execution time & inference count
run_benchmark :-
    statistics(runtime, _),
    statistics(inferences, InfStart),
    zebra(_List),
    statistics(inferences, InfEnd),
    statistics(runtime, [_, Time]),
    Inferences is InfEnd - InfStart,
    format('Execution time: ~w ms~n
