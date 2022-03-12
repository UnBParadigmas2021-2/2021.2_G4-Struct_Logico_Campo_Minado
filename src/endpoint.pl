:- use_module(library(http/http_files)).
:- use_module(library(http/html_write)).

:- http_handler('/', minesweeper, []).

:- http_handler('/hi', say_hi, []).

minesweeper(_Request) :-
	reply_html_page(
	   [title('Minesweeper')],
	   [p('Hello, I am using Prolog on Docker!')]).

say_hi(_Request) :-
	reply_html_page(
	   [title('Endpoint /hi')],
	   [h1('Example of how do create an endpoint'),
	    p('With some text')]).
