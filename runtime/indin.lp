happens(use(glucose),X1) :- use(1,0),try(1,1,vars(X1)),try(1,2,vars(X1)),time(X1).
try(1,1,vars(X1)) :- use(1,1),holdsAt(available(glucose),X1),time(X1).
try(1,1,vars(X1)) :- not use(1,1),time(X1).
try(1,2,vars(X1)) :- use(1,2),holdsAt(available(lactose),X1),time(X1).
try(1,2,vars(X1)) :- not use(1,2),time(X1).
happens(use(lactose),X1) :- use(2,0),try(2,1,vars(X1)),try(2,2,vars(X1)),time(X1).
try(2,1,vars(X1)) :- use(2,1),holdsAt(available(lactose),X1),time(X1).
try(2,1,vars(X1)) :- not use(2,1),time(X1).
try(2,2,vars(X1)) :- use(2,2),not_holdsAt(available(glucose),X1),time(X1).
try(2,2,vars(X1)) :- not use(2,2),time(X1).



clauseIndex(1..2).

literalIndex(0..3).

{use(1,1..2)}.{use(2,1..2)}.



{use(I,J)}:-clauseIndex(I),literalIndex(J).

{use(I,J,K)}:-clauseIndex(I),clauseIndex(J),literalIndex(K).

#minimize{use(I,J),use(I,J,K)}.

:- use(I,J), not use(I,0).

#hide.

#show use/2.

#show use/3.