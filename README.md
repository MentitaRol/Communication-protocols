# Demonstration of a Programming Paradigm - Communication protocols

## Description

### Logic paradigm
Paradigm is the approach adopted to reach out to the solution of a problem. Paradigms in programming can be understood as the methodology adopted to solve some specific problem with the help of some programming languages, tools or techniques (Sharma, 2022).

A logic program consists of a collection of facts and rules that describe the relationships and properties of entities, and a query language that allows you to ask questions and obtain answers from the program. A logic programming paradigm defines the syntax and semantics of the facts, rules, and queries, as well as the inference mechanism that derives new facts and rules from existing ones (LinkedIn, 2023).

### Finite State Machine 
Finite automata are abstract machines used to recognize patterns in input sequences. 

The basic structure of a Finite State Machine or Finite Automata consists of a finite set of states, transitions between these states, and a set of events or inputs that trigger these transitions. Each state represents a condition or situation in the system, and transitions define how the system changes from one state to another in response to specific events (Foqum Analytics, 2024).

Finite automata can be classified as:
•	Deterministic Finite Automaton (DFA) – A structured model where each state has a unique transition for every input symbol. (GeeksforGeeks, 2024)

•	Non-Deterministic Finite Automaton (NFA) – A more flexible model where multiple transitions for the same input symbol can exist. (GeeksforGeeks, 2024)

### Finite Automata in Network Protocol
Deterministic Finite Automata (DFA) are particularly useful in the context of networking, as they enable the formal modeling and analysis of communication protocols. By representing the different states and transitions of a protocol, DFAs make it possible to detect design errors such as deadlocks, boundedness violations, and unspecified receptions. They provide a rigorous framework to describe the sequence of events that occur during network communications, allowing for the simulation and verification of protocol behaviors such as those in TCP/IP, HTTP, and HTTPS (GeeksforGeeks, 2023).

This project applies the logic programming paradigm to model and verify communication protocols through the use of finite automata. This type of verification is essential for ensuring that information is transmitted efficiently, securely, and reliably between devices or applications. By formally analyzing the protocol’s flow, the system can help prevent miscommunications, detect inconsistencies, and protect data integrity and security in networked environments. (Ikusi, 2023)
For this demonstration I decided to work with the TCP/IP model. As context, the TCP/IP model (Transmission Control Protocol/Internet Protocol) is a four-layer networking framework that enables reliable communication between devices over interconnected networks. It provides a standardized set of protocols.

for transmitting data across interconnected networks, ensuring efficient and error-free delivery. Each layer has specific functions that help manage different aspects of network communication, making it essential for understanding and working with modern networks (GeeksforGeeks, 2025).
To maintain the scope of the project, I decided to make a very general abstraction of the TCP/IP model. This abstraction is simplified yet explicit enough to demonstrate the core behavior of the protocols involved.
Of the four layers, I will only be modeling three, each represented by a key protocol:

**Application Layer:**
This is closest to the end user and is where applications and user interfaces reside. It serves as the bridge between user programs and the lower layers responsible for data transmission (GeeksforGeeks, 2025).

We will model the HTTP protocol.

**Transport Layer:**
Ensures data is delivered reliably and in the correct order between devices (GeeksforGeeks, 2025).

We will model the TCP protocol.

**Network Layer:**
This handles the routing of data packets across networks (GeeksforGeeks, 2025).

We will model the IP protocol.

## Models
To simulate the behavior of these protocols, I will use the implementation of Deterministic Finite Automata (DFA).

**1.- HTTP protocol:**

The HTTP protocol captures the typical client-server interaction over the web. The general flow being simulated includes a client sending an HTTP request to a server, and the server returning an appropriate HTTP response based on the validity and type of the request.

The automaton starts with the client initiating a request. The DFA distinguishes between two main types of HTTP requests: GET and POST. Depending on the type of request, the flow diverges:
If the request is a valid GET/POST request, the server responds with a 200 OK message and proceeds with the delivery of the requested content. (This will be shown more explicitly in the implementation part).
If the request is malformed or includes invalid elements (such as a missing path or incorrect syntax), the DFA transitions to an error state and returns a 400 Bad Request response. (This will be shown more explicitly in the implementation part).
Each state transition in the DFA corresponds to a valid stage in the request-response cycle, and only sequences that follow the correct protocol semantics are accepted. 

![Image](https://github.com/user-attachments/assets/250237b1-a460-4ccc-8dd0-236f748733f4)

**2.- TCP protocol:**
The TCP protocol represents the stages of a reliable connection between two endpoints. The automaton captures the essential parts of the TCP lifecycle: connection establishment, data transmission, and connection termination.

The DFA begins in an initial state where the client initiates a connection by sending a SYN packet. The server responds with a SYN/ACK, and the client completes the handshake with an ACK. The transition to the termination phase is triggered by the client or server sending a FIN/ACK, followed by a final ACK to confirm the connection closure.
If at any point the expected packet is missing or out of order, the automaton transitions to an error state, modeling how TCP detects and responds to protocol violations or corrupted communication attempts. (This will be shown more explicitly in the implementation part).

![Image](https://github.com/user-attachments/assets/c5815103-0ccc-4529-b2a3-d6bd5dab67ae)

**3.- IP protocol:**
The IP (Internet Protocol) automaton focuses on the behavior of packet delivery across networks, specifically simulating the transmission and routing of datagrams.
The DFA begins with a valid packet being created. We simulate the information each packet will be carrying with datagrams containing IP information and information that helps ensure the packets arrive at the correct location. We also simulate the TTL, which is the time a packet has before being discarded. If the time is equal to zero, the packet is discarded simulating a dropped or undelivered packet. If all required components are present and valid, the packet is routed and successfully delivered.

![Image](https://github.com/user-attachments/assets/e2ac567d-6287-46f8-90d6-ed7c76079bea)


The logical paradigm is particularly suited for this kind of modeling because it allows the explicit declaration of transitions (rules) and accepted patterns (facts) based on formal logic.

Each protocol is modeled as a finite set of valid transitions between well-defined states, capturing its essential behavior through logical predicates. These predicates define how input sequences are processed and validated, reflecting the protocol's internal logic and flow. By structuring the protocol behavior as logic rules, we ensure that each automaton deterministically accepts or rejects a sequence based on compliance with its protocol’s rules.

This approach not only illustrates the operation of the TCP/IP layers, but also demonstrates how logical programming enables concise, declarative representations of systems with structured behavior.

## Implementation
For the implementation, we'll be working with Prolog. We'll be working with each automation individually to modulate the processes and make them easier to work with. These three automatons will then be connected to each other to simulate the complete data communication flow.

Since the three protocol automatons follow the same logic and structure, I'll explain the general process and the protocol specifications.

The first step in the implementation is to model the transitions between states and the corresponding inputs that trigger them. To represent these transitions, we will define a set of Prolog facts using the following structure:

    transition (currentState, instruction, nextState)

This structure allows us to clearly define the deterministic behavior of the automaton, where each transition is uniquely determined by the current state and the input symbol.

After this we will define the final states or accepted states:

    final_http(q6).

Once the transitions have been defined, we proceed to implement the rule that initiates the simulation process. This rule receives the entire instruction segment and depending on the protocol is where the acceptance or rejection messages will be defined.

**HTTP Protocol:**

    start_http(Petition):-
        process_http(Petition,q0),
        write('ServerHello'),nl,
        write('HTTP 200 OK'),nl.

    start_http(_):-
        write('HTTP 400 Bad Request'),nl,
        fail.

**TCP protocol:**

    start_tcp(Petition):-
        process_tcp(Petition,q0),
        write('Connection Established'),nl,
        write('Data transfer begins...'),nl.

    start_tcp(_):-
        write('Connection Failed'),nl,
        fail.

**IP protocol:**

    start_ip(Petition):-
        process_ip(Petition,q0),
        write('Delivered'),nl.

    start_ip(_):-
        write('Drop'),nl,
        fail.

Our base case is defined for the moment when all instructions of the protocol have been traversed. At this point, the simulation verifies whether the current state is an accepting state according:

    process_http([],CurrentState):-
        final_http(CurrentState).

The recursive case allows the automaton to process the sequence of instructions one by one, analyzing the current state and the input to determine the next valid state according to the transition rules:

    process_http([Instruction|RestOfInstruction],CurrentState):-
        http_transition(CurrentState,NextState,Instruction),
        process_http(RestOfInstruction,NextState).

For the HTTP and IP protocol, there will be an additional rule to process transitions. These rules introduce dynamic validation based on the type or value of the input, allowing the automaton to flexibly accept a wider range of valid inputs.

**HTTP protocol:**

    process_http([Domain|Rest], q5) :-
        atom(Domain),
        process_http(Rest, q6).

    process_http([Data|Rest], q8) :-
        number(Data),
        process_http(Rest, q6).

**IP protocol:**

    process_ip([TTL|Rest],q2):-
        number(TTL),
        TTL > 0,
        process_ip(Rest,q3).

## Tests
