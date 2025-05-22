
:-["protocol_comunication"].

%Test cases:

%Empty list
test0:-
    start_comunication([],[],[]).

%Accepting test cases
test1:-
    start_comunication([clientHello,get,/,www,.,youtube],
                       [syn,syn/ack,ack,data,fin/ack,ack,fin/ack,ack,end],
                       [packet,datagram,4,fragmentation,dest]).
test2:-
    start_comunication([clientHello,get,/,www,.,amazon],
                       [syn,syn/ack,ack,data,fin/ack,ack,fin/ack,ack,end],
                       [packet,datagram,10,fragmentation,dest]).
test3:-
    start_comunication([clientHello,get,/,www,.,wikipedia],
                       [syn,syn/ack,ack,data,fin/ack,ack,fin/ack,ack,end],
                       [packet,datagram,37,fragmentation,dest]).
test4:-
    start_comunication([clientHello,get,/,www,.,github],
                       [syn,syn/ack,ack,data,fin/ack,ack,fin/ack,ack,end],
                       [packet,datagram,1,fragmentation,dest]).
test5:-
    start_comunication([clientHello,get,/,www,.,google],
                       [syn,syn/ack,ack,data,fin/ack,ack,fin/ack,ack,end],
                       [packet,datagram,5,fragmentation,dest]).
test6:-
    start_comunication([clientHello,post,/,123456],
                       [syn,syn/ack,ack,data,fin/ack,ack,fin/ack,ack,end],
                       [packet,datagram,16,fragmentation,dest]).
test7:-
    start_comunication([clientHello,post,/,10],
                       [syn,syn/ack,ack,data,fin/ack,ack,fin/ack,ack,end],
                       [packet,datagram,120,fragmentation,dest]).
test8:-
    start_comunication([clientHello,post,/,100],
                       [syn,syn/ack,ack,data,fin/ack,ack,fin/ack,ack,end],
                       [packet,datagram,2,fragmentation,dest]).
test9:-
    start_comunication([clientHello,post,/,-10],
                       [syn,syn/ack,ack,data,fin/ack,ack,fin/ack,ack,end],
                       [packet,datagram,2,fragmentation,dest]).

%Incorrect test cases
test10:-
    start_comunication([clientHello,get,/,blog,.,kick],
                       [syn,syn/ack,ack,data,fin/ack,ack,fin/ack,ack,end],
                       [packet,datagram,4,fragmentation,dest]).
test11:-
    start_comunication([clientHello,get,#,www,.,facebook],
                       [syn,syn/ack,ack,data,fin/ack,ack,fin/ack,ack,end],
                       [packet,datagram,4,fragmentation,dest]).
test12:-
    start_comunication([clientHello,get,/,www,.,facebook],
                       [syn,syn/ack,ack,image1234,fin/ack,ack,fin/ack,ack,end],
                       [packet,123456,4,fragmentation,dest]).
test13:-
    start_comunication([clientHello,post,/,10],
                       [syn,syn/ack,ack,data,fin/ack,ack,fin/ack,ack,end],
                       [packet,datagram,0,fragmentation,dest]).
test14:-
    start_comunication([clientHello,post,/,senddata],
                       [syn,syn/ack,ack,data,fin/ack,ack,fin/ack,ack,end],
                       [packet,datagram,20,fragmentation,dest]).
test15:-
    start_comunication([clientHello,post,/,24],
                       [syn,syn/ack,ack,data,fin/ack,ack,fin/ack,ack,end],
                       [packet,datagram,-10,fragmentation,dest]).
test16:-
    start_comunication([clientHello,post,/,12056],
                       [syn,syn/ack,ack,data,fin/ack,ack,notfin,ack,end],
                       [packet,datagram,8,fragmentation,dest]).
test17:-
    start_comunication([clientHello,post,/,12056],
                       [syn,0,ack,data,fin/ack,ack,fin/ack,ack,end],
                       [packet,datagram,8,fragmentation,dest]).


run_tests :-
    (write('Test 0:'), nl, nl, (test0 ; true), nl,
     write('Test 1:'), nl, nl, (test1 ; true), nl,
     write('Test 2:'), nl, nl, (test2 ; true), nl,
     write('Test 3:'), nl, nl, (test3 ; true), nl,
     write('Test 4:'), nl, nl, (test4 ; true), nl,
     write('Test 5:'), nl, nl, (test5 ; true), nl,
     write('Test 6:'), nl, nl, (test6 ; true), nl,
     write('Test 7:'), nl, nl, (test7 ; true), nl,
     write('Test 8:'), nl, nl, (test8 ; true), nl,
     write('Test 9:'), nl, nl, (test9 ; true), nl,
     write('Test 10:'), nl, nl, (test10 ; true), nl,
     write('Test 11:'), nl, nl, (test11 ; true), nl,
     write('Test 12:'), nl, nl, (test12 ; true), nl,
     write('Test 13:'), nl, nl, (test13 ; true), nl,
     write('Test 14:'), nl, nl, (test14 ; true), nl,
     write('Test 15:'), nl, nl, (test15 ; true), nl,
     write('Test 16:'), nl, nl, (test16 ; true), nl,
     write('Test 17:'), nl, nl, (test17 ; true), nl).
