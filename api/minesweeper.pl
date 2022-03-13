:- dynamic pos/3.
:- dynamic mine/2.
:- dynamic seed/0.

seed_minesweeper :- seed_mine(0), seed_pos(0).

seed_mine(10).
seed_mine(N):-
  S is N+1,
	random_between(0, 9, Row),
	random_between(0, 9, Column),
	assert(mine(Row, Column)),
	seed_mine(S).

seed_pos(10).
seed_pos(Row) :-
	S is Row+1,
	seed_row(0, Row),
	seed_pos(S).

seed_row(10, _).
seed_row(Column, Row) :-
	S is Column+1,
	ifThenElse(mine(Row, Column), assert(pos(Row, Column, 9)), seed_safe_positions(Row, Column)),
	seed_row(S, Row).

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

check_if_is_mine(Row, Column) :-
  ifThenElse(check_borders(Row, Column), mine(Row, Column), false).

check_borders(Row, Column) :-
  Row < 10,
  Column < 10,
  Row > -1,
  Column > -1.
