%IP Protocol

%Transitions of the automaton
ip_transition(q0,q1,packet).
ip_transition(q1,q2,datagram).
ip_transition(q3,q4,fragmentation).
ip_transition(q4,q5,dest).

%Final or accepting states
final_ip(q5).

% Start the automaton by processing the petition from the initial state
start_ip(Petition):-
    process_ip(Petition,q0),
    write('Delivered'),nl.

start_ip(_):-
    write('Drop'),nl,
    fail.

%Base case:
% If we have gone through the entire list
% check if we are in a final state.
process_ip([],CurrentState):-
    final_ip(CurrentState).

%Recursive case:
% If there are still elements, check for valid transitions.
process_ip([Instruction|RestOfInstruction],CurrentState):-
    ip_transition(CurrentState,NextState,Instruction),
    process_ip(RestOfInstruction,NextState).

%Validation to only accept TTLs greater than 0
process_ip([TTL|Rest],q2):-
    number(TTL),
    TTL > 0,
    process_ip(Rest,q3).
