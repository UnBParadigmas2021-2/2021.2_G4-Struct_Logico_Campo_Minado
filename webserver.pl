:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_files)).
:- use_module(library(http/html_write)).

server(Port) :-
    http_server(http_dispatch, [port(Port)]).
 
:- http_handler('/', http_reply_from_files('src', []), []).

:- http_handler('/hi', say_hi, []).

say_hi(_Request) :-
	reply_html_page(
	   [title('Endpoint /hi')],
	   [h1('Example of how do create an endpoint'),
	    p('With some text')]).

run :-
    server(8000),
    repeat,
    sleep(10),
    fail.

:- run.
