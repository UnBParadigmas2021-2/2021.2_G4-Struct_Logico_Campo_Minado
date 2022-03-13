ifThenElse(X,Y,_) :- X,!,Y.
ifThenElse(_,_,Z) :- Z.

add(X, Y, N) :-
  number(X),
  number(Y),
  N is X + Y.
