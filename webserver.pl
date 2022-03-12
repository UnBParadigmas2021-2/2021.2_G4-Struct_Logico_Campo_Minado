:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).

server(Port) :-
    http_server(http_dispatch, [port(Port)]).
 
:- include('src/endpoint.pl').

run :-
    server(8000),
    repeat,
    sleep(10),
    fail.

:- run.
