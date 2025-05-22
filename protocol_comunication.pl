%Load all the protocol code files

%HTTP
:-["http"].

%TCP
:-["tcp"].

%IP
:-["ip"].

start_comunication(HTTP, TCP, IP) :-
    (start_http(HTTP) ->
        (start_tcp(TCP) ->
            (start_ip(IP) ->
                write('Communication successful'), nl
            ;
                write('Communication failed (IP)'), nl,
                fail
            )
        ;
            write('Communication failed (TCP)'), nl,
            fail
        )
    ;
        write('Communication failed (HTTP)'), nl,
        fail
    ).

