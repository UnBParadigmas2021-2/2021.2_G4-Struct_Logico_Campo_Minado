:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).

server(Port) :-
    http_server(http_dispatch, [port(Port)]).
 
:- include('api/helpers.pl').
:- include('api/minesweeper.pl').
:- include('api/endpoints.pl').

run :-
    server(8000),
    repeat,
    sleep(10),
    fail.

:- run.
