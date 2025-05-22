%HTTP Protocol

%Transitions of the automaton
http_transition(q0,q1,clientHello).
http_transition(q1,q2,get).
http_transition(q2,q3,'/').
http_transition(q3,q4,www).
http_transition(q4,q5,'.').
http_transition(q1,q7,post).
http_transition(q7,q8,'/').
http_transition(q8,q6,data).

%Final or accepting states
final_http(q6).

%Start the automaton by processing the petition from the initial state
start_http(Petition):-
    process_http(Petition,q0),
    write('ServerHello'),nl,
    write('HTTP 200 OK'),nl.

start_http(_):-
    write('HTTP 400 Bad Request'),nl,
    fail.

%Base case:
%If we have gone through the entire list
%check if we are in a final state.
process_http([],CurrentState):-
    final_http(CurrentState).

%Recursive case:
%If there are still elements, check for valid transitions.
process_http([Instruction|RestOfInstruction],CurrentState):-
    % Ensure a valid transition exists
    http_transition(CurrentState,NextState,Instruction),
    % Call the recursive case
    process_http(RestOfInstruction,NextState).

%Dynamic validations
process_http([Domain|Rest], q5) :-
    atom(Domain),
    process_http(Rest, q6).

process_http([Data|Rest], q8) :-
    number(Data),
    process_http(Rest, q6).
