:- use_module(library(http/http_files)).
:- use_module(library(http/html_write)).
:- use_module(library(http/http_json)).

:- http_handler('/', minesweeper, []).

:- http_handler('/get-mine', get_mine, []).

range(X,X,[X]) :- !.
range(X,Y,[X|Xs]) :-
    X =< Y,
    Z is X+1,
    range(Z,Y,Xs).

mine(0,0).
mine(1,1).
mine(2,2).
mine(3,3).
mine(4,4).
mine(5,5).
mine(6,6).
mine(7,7).
mine(8,8).
mine(9,9).

pos(X, Y, V) :- 
	range(0,9,X), 
	range(0,9,Y),
	ifThenElse(mine(X,Y), V is 9, V is 0).

ifThenElse(X,Y,_) :- X,!,Y.
ifThenElse(_,_,Z) :- Z.

minesweeper(_Request) :-
	reply_html_page(
	   [title('Minesweeper')],
	   [p('Hello, I am using Prolog on Docker!')]).

get_mine(Request) :-
	http_read_json_dict(Request, DictIn),
    return_mine(DictIn, DictOut),
    reply_json(DictOut).

return_mine(_{x: X, y: Y}, _{mine: [R0,R1,R2,R3,R4,R5,R6,R7,R8,R9]}) :-
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
