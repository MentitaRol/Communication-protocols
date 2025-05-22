%TCP Protocol

%Transitions of the automaton
tcp_transition(q0,q1,syn).
tcp_transition(q1,q2,syn/ack).
tcp_transition(q2,q3,ack).
tcp_transition(q3,q4,data).
tcp_transition(q4,q5,fin/ack).
tcp_transition(q5,q6,ack).
tcp_transition(q6,q7,fin/ack).
tcp_transition(q7,q8,ack).
tcp_transition(q8,q9,end).

%Final or accepting states
final_tcp(q9).

% Start the automaton by processing the petition from the initial state
start_tcp(Petition):-
    process_tcp(Petition,q0),
    write('Connection Established'),nl,
    write('Data transfer begins...'),nl.

start_tcp(_):-
    write('Connection Failed'),nl,
    fail.

%Base case:
% If we have gone through the entire list
% check if we are in a final state.
process_tcp([],CurrentState):-
    final_tcp(CurrentState).

%Recursive case:
% If there are still elements, check for valid transitions.
process_tcp([Instruction|RestOfInstruction], CurrentState):-
    % Ensure a valid transition exists
    tcp_transition(CurrentState,NextState,Instruction),
    % Call the recursive case
    process_tcp(RestOfInstruction,NextState).











