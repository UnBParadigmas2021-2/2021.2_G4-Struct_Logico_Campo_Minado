:- use_module(library(http/http_files)).
:- use_module(library(http/html_write)).
:- use_module(library(http/http_json)).

:- http_handler('/', minesweeper, []).
:- http_handler('/get-mine', get_mine, []).

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