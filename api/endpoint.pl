:- use_module(library(http/http_files)).
:- use_module(library(http/html_write)).
:- use_module(library(http/http_json)).

:- http_handler('/', minesweeper, []).
:- http_handler('/get-mine', get_mine, []).

:- dynamic pos/3.
:- dynamic mine/2.
:- dynamic seed/0.

ifThenElse(X,Y,_) :- X,!,Y.
ifThenElse(_,_,Z) :- Z.

add(X, Y, N) :-
  number(X),
  number(Y),
  N is X + Y.

seed_mine(10).
seed_mine(N):-
  S is N+1,
	random_between(0, 9, Row),
	random_between(0, 9, Column),
	assert(mine(Row, Column)),
	seed_mine(S).

check_borders(Row, Column) :-
  Row < 10,
  Column < 10,
  Row > -1,
  Column > -1.

check_if_is_mine(Row, Column) :-
  ifThenElse(check_borders(Row, Column), mine(Row, Column), false).

seed_safe_positions(Row, Column) :-
  add(Row, 1, RowPlus),
  add(Row, -1, RowMinus),
  add(Column, 1, ColumnPlus),
  add(Column, -1, ColumnMinus),
	ifThenElse(check_if_is_mine(RowPlus, Column), A = 1, A = 0),
	ifThenElse(check_if_is_mine(RowPlus, ColumnPlus), B = 1, B = 0),
	ifThenElse(check_if_is_mine(RowPlus, ColumnMinus), C = 1, C = 0),
	ifThenElse(check_if_is_mine(RowMinus, Column), D = 1, D = 0),
	ifThenElse(check_if_is_mine(RowMinus, ColumnPlus), E = 1, E = 0),
	ifThenElse(check_if_is_mine(RowMinus, ColumnMinus), F = 1, F = 0),
	ifThenElse(check_if_is_mine(Row, ColumnPlus), G = 1, G = 0),
	ifThenElse(check_if_is_mine(Row, ColumnMinus), H = 1, H = 0),
  add(A, B, C1),
  add(C1, C, D1),
  add(D1, D, E1),
  add(E1, E, F1),
  add(F1, F, G1),
  add(G1, G, H1),
  add(H1, H, Value),
	assert(pos(Row, Column, Value)).

seed_row(10, _).
seed_row(Column, Row) :-
	S is Column+1,
	ifThenElse(mine(Row, Column), assert(pos(Row, Column, 9)), seed_safe_positions(Row, Column)),
	seed_row(S, Row).

seed_pos(10).
seed_pos(Row) :-
	S is Row+1,
	seed_row(0, Row),
	seed_pos(S).

seed_minesweeper :- seed_mine(0), seed_pos(0).

minesweeper(_Request) :-
	reply_html_page(
	   [title('Minesweeper')],
	   [p('Hello, I am using Prolog on Docker!')]).

get_mine(_Request) :-
	ifThenElse(seed, true, seed_minesweeper),
	assert(seed),
  return_mine(DictOut),
  reply_json(DictOut).

return_mine(_{mine: [R0,R1,R2,R3,R4,R5,R6,R7,R8,R9]}) :-
	findall(E, pos(0, _, E), R0),
	findall(E, pos(1, _, E), R1),
	findall(E, pos(2, _, E), R2),
	findall(E, pos(3, _, E), R3),
	findall(E, pos(4, _, E), R4),
	findall(E, pos(5, _, E), R5),
	findall(E, pos(6, _, E), R6),
	findall(E, pos(7, _, E), R7),
	findall(E, pos(8, _, E), R8),
	findall(E, pos(9, _, E), R9).
