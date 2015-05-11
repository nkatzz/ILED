%-------------------------
%% Event Calculus axioms: 
%-------------------------

% An fluent F holds at time T if an event E 
% happens at some time point S prior to T,
% such that E initiates F at time S, and also
% F has not been clipped (interrupted) in the
% time interval [S,T].   
holdsAt(F,T) :- 
     happens(E,S), 
     S<T, 
     time(S),time(T),
     initiates(E,F,S), 
     not clipped(S,F,T). 

% Fluent F is clipped in the time interval [S,T] 
% if an event E happens at some time point R 
% in this interval, such that E terminates F at R 
clipped(S,F,T) :-
     happens(E,R), 
     S<R, R<T,
     time(S),time(R),time(T),  
     terminates(E,F,R). 

% Fluent F holds at time T if it holds at time 0
% (the begining of time) and it has not been 
% clipped since.
holdsAt(F,T) :-
     initially(F), 
     not clipped(0,F,T),
     time(T).
    
%% Time ranges from 0 to 9:
time(0..9). 

%% Definition of events:
event(add(G)) :- sugar(G).
event(use(G)) :- sugar(G). 

%% Definitions of fluents:
fluent(available(G)) :- sugar(G). 

%% Lactose and glucose are sugars:
sugar(lactose).
sugar(glucose). 

%% Adding a sugar initiates its availability:
initiates(add(G),available(G),T) :- sugar(G), time(T).

%% Consuming a sugar terminates it availability:
 terminates(use(G),available(G),T) :- sugar(G), time(T). 

%% Integrity constraint: A non-available sugar cannot be consumed:
:- happens(use(G),T), not holdsAt(available(G), T). 
                  
%% At time 0 we add lactose and glucose (and let the system eveolve):
happens(add(lactose),0).
happens(add(glucose),0).

%% This is not really necessary, not holdsAt(X,Y) may be used instead.
not_holdsAt(X,Y):- 
   not holdsAt(X,Y),fluent(X),time(Y). 


