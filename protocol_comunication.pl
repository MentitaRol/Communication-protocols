%Load all the protocol code files

%HTTP
:-["http"].

%TCP
:-["tcp"].

%IP
:-["ip"].


start_comunication(HTTP,TCP,IP):-
    start_http(HTTP), !,
    start_tcp(TCP), !,
    start_ip(IP), !,
    write('Communication successful'), nl.

start_comunication(_,_,_):-
    write('Communication failed'),
    fail.


