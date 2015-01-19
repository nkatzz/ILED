initiatedAt(punctuality(X3,X1,punctual),X2) :- use(1,0),try(1,1,vars(X2,X3,X1)),try(1,2,vars(X2,X3,X1)),try(1,3,vars(X2,X3,X1)),try(1,4,vars(X2,X3,X1)),try(1,5,vars(X2,X3,X1)),try(1,6,vars(X2,X3,X1)),try(1,7,vars(X2,X3,X1)),try(1,8,vars(X2,X3,X1)),ttime(X2),vehicleId(X3),vehicleType(X1).
try(1,1,vars(X2,X3,X1)) :- use(1,1),initiatedAt(punctuality(X3,X1,punctual),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(1,1,vars(X2,X3,X1)) :- not use(1,1),ttime(X2),vehicleId(X3),vehicleType(X1).
try(1,2,vars(X2,X3,X1)) :- use(1,2),terminatedAt(punctuality(X3,X1,non_punctual),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(1,2,vars(X2,X3,X1)) :- not use(1,2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(1,3,vars(X2,X3,X1)) :- use(1,3),happensAt(my_stop_enter(X3,X1,stopId,early),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(1,3,vars(X2,X3,X1)) :- not use(1,3),ttime(X2),vehicleId(X3),vehicleType(X1).
try(1,4,vars(X2,X3,X1)) :- use(1,4),not_happensAt(my_stop_enter(X3,X1,stopId,scheduled),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(1,4,vars(X2,X3,X1)) :- not use(1,4),ttime(X2),vehicleId(X3),vehicleType(X1).
try(1,5,vars(X2,X3,X1)) :- use(1,5),not_happensAt(my_stop_enter(X3,X1,stopId,late),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(1,5,vars(X2,X3,X1)) :- not use(1,5),ttime(X2),vehicleId(X3),vehicleType(X1).
try(1,6,vars(X2,X3,X1)) :- use(1,6),not_happensAt(my_stop_leave(X3,X1,stopId,scheduled),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(1,6,vars(X2,X3,X1)) :- not use(1,6),ttime(X2),vehicleId(X3),vehicleType(X1).
try(1,7,vars(X2,X3,X1)) :- use(1,7),not_happensAt(my_stop_leave(X3,X1,stopId,early),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(1,7,vars(X2,X3,X1)) :- not use(1,7),ttime(X2),vehicleId(X3),vehicleType(X1).
try(1,8,vars(X2,X3,X1)) :- use(1,8),not_happensAt(my_stop_leave(X3,X1,stopId,late),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(1,8,vars(X2,X3,X1)) :- not use(1,8),ttime(X2),vehicleId(X3),vehicleType(X1).
initiatedAt(punctuality(X3,X1,non_punctual),X2) :- use(2,0),try(2,1,vars(X2,X3,X1)),try(2,2,vars(X2,X3,X1)),try(2,3,vars(X2,X3,X1)),try(2,4,vars(X2,X3,X1)),try(2,5,vars(X2,X3,X1)),try(2,6,vars(X2,X3,X1)),try(2,7,vars(X2,X3,X1)),try(2,8,vars(X2,X3,X1)),ttime(X2),vehicleId(X3),vehicleType(X1).
try(2,1,vars(X2,X3,X1)) :- use(2,1),initiatedAt(punctuality(X3,X1,non_punctual),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(2,1,vars(X2,X3,X1)) :- not use(2,1),ttime(X2),vehicleId(X3),vehicleType(X1).
try(2,2,vars(X2,X3,X1)) :- use(2,2),terminatedAt(punctuality(X3,X1,punctual),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(2,2,vars(X2,X3,X1)) :- not use(2,2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(2,3,vars(X2,X3,X1)) :- use(2,3),happensAt(my_stop_enter(X3,X1,stopId,late),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(2,3,vars(X2,X3,X1)) :- not use(2,3),ttime(X2),vehicleId(X3),vehicleType(X1).
try(2,4,vars(X2,X3,X1)) :- use(2,4),not_happensAt(my_stop_enter(X3,X1,stopId,scheduled),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(2,4,vars(X2,X3,X1)) :- not use(2,4),ttime(X2),vehicleId(X3),vehicleType(X1).
try(2,5,vars(X2,X3,X1)) :- use(2,5),not_happensAt(my_stop_enter(X3,X1,stopId,early),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(2,5,vars(X2,X3,X1)) :- not use(2,5),ttime(X2),vehicleId(X3),vehicleType(X1).
try(2,6,vars(X2,X3,X1)) :- use(2,6),not_happensAt(my_stop_leave(X3,X1,stopId,scheduled),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(2,6,vars(X2,X3,X1)) :- not use(2,6),ttime(X2),vehicleId(X3),vehicleType(X1).
try(2,7,vars(X2,X3,X1)) :- use(2,7),not_happensAt(my_stop_leave(X3,X1,stopId,early),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(2,7,vars(X2,X3,X1)) :- not use(2,7),ttime(X2),vehicleId(X3),vehicleType(X1).
try(2,8,vars(X2,X3,X1)) :- use(2,8),not_happensAt(my_stop_leave(X3,X1,stopId,late),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(2,8,vars(X2,X3,X1)) :- not use(2,8),ttime(X2),vehicleId(X3),vehicleType(X1).
terminatedAt(punctuality(X3,X1,non_punctual),X2) :- use(3,0),try(3,1,vars(X2,X3,X1)),try(3,2,vars(X2,X3,X1)),try(3,3,vars(X2,X3,X1)),try(3,4,vars(X2,X3,X1)),try(3,5,vars(X2,X3,X1)),try(3,6,vars(X2,X3,X1)),try(3,7,vars(X2,X3,X1)),try(3,8,vars(X2,X3,X1)),ttime(X2),vehicleId(X3),vehicleType(X1).
try(3,1,vars(X2,X3,X1)) :- use(3,1),initiatedAt(punctuality(X3,X1,punctual),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(3,1,vars(X2,X3,X1)) :- not use(3,1),ttime(X2),vehicleId(X3),vehicleType(X1).
try(3,2,vars(X2,X3,X1)) :- use(3,2),terminatedAt(punctuality(X3,X1,non_punctual),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(3,2,vars(X2,X3,X1)) :- not use(3,2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(3,3,vars(X2,X3,X1)) :- use(3,3),happensAt(my_stop_enter(X3,X1,stopId,early),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(3,3,vars(X2,X3,X1)) :- not use(3,3),ttime(X2),vehicleId(X3),vehicleType(X1).
try(3,4,vars(X2,X3,X1)) :- use(3,4),not_happensAt(my_stop_enter(X3,X1,stopId,scheduled),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(3,4,vars(X2,X3,X1)) :- not use(3,4),ttime(X2),vehicleId(X3),vehicleType(X1).
try(3,5,vars(X2,X3,X1)) :- use(3,5),not_happensAt(my_stop_enter(X3,X1,stopId,late),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(3,5,vars(X2,X3,X1)) :- not use(3,5),ttime(X2),vehicleId(X3),vehicleType(X1).
try(3,6,vars(X2,X3,X1)) :- use(3,6),not_happensAt(my_stop_leave(X3,X1,stopId,scheduled),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(3,6,vars(X2,X3,X1)) :- not use(3,6),ttime(X2),vehicleId(X3),vehicleType(X1).
try(3,7,vars(X2,X3,X1)) :- use(3,7),not_happensAt(my_stop_leave(X3,X1,stopId,early),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(3,7,vars(X2,X3,X1)) :- not use(3,7),ttime(X2),vehicleId(X3),vehicleType(X1).
try(3,8,vars(X2,X3,X1)) :- use(3,8),not_happensAt(my_stop_leave(X3,X1,stopId,late),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(3,8,vars(X2,X3,X1)) :- not use(3,8),ttime(X2),vehicleId(X3),vehicleType(X1).
terminatedAt(punctuality(X3,X1,punctual),X2) :- use(4,0),try(4,1,vars(X2,X3,X1)),try(4,2,vars(X2,X3,X1)),try(4,3,vars(X2,X3,X1)),try(4,4,vars(X2,X3,X1)),try(4,5,vars(X2,X3,X1)),try(4,6,vars(X2,X3,X1)),try(4,7,vars(X2,X3,X1)),try(4,8,vars(X2,X3,X1)),ttime(X2),vehicleId(X3),vehicleType(X1).
try(4,1,vars(X2,X3,X1)) :- use(4,1),initiatedAt(punctuality(X3,X1,non_punctual),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(4,1,vars(X2,X3,X1)) :- not use(4,1),ttime(X2),vehicleId(X3),vehicleType(X1).
try(4,2,vars(X2,X3,X1)) :- use(4,2),terminatedAt(punctuality(X3,X1,punctual),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(4,2,vars(X2,X3,X1)) :- not use(4,2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(4,3,vars(X2,X3,X1)) :- use(4,3),happensAt(my_stop_enter(X3,X1,stopId,late),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(4,3,vars(X2,X3,X1)) :- not use(4,3),ttime(X2),vehicleId(X3),vehicleType(X1).
try(4,4,vars(X2,X3,X1)) :- use(4,4),not_happensAt(my_stop_enter(X3,X1,stopId,scheduled),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(4,4,vars(X2,X3,X1)) :- not use(4,4),ttime(X2),vehicleId(X3),vehicleType(X1).
try(4,5,vars(X2,X3,X1)) :- use(4,5),not_happensAt(my_stop_enter(X3,X1,stopId,early),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(4,5,vars(X2,X3,X1)) :- not use(4,5),ttime(X2),vehicleId(X3),vehicleType(X1).
try(4,6,vars(X2,X3,X1)) :- use(4,6),not_happensAt(my_stop_leave(X3,X1,stopId,scheduled),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(4,6,vars(X2,X3,X1)) :- not use(4,6),ttime(X2),vehicleId(X3),vehicleType(X1).
try(4,7,vars(X2,X3,X1)) :- use(4,7),not_happensAt(my_stop_leave(X3,X1,stopId,early),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(4,7,vars(X2,X3,X1)) :- not use(4,7),ttime(X2),vehicleId(X3),vehicleType(X1).
try(4,8,vars(X2,X3,X1)) :- use(4,8),not_happensAt(my_stop_leave(X3,X1,stopId,late),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(4,8,vars(X2,X3,X1)) :- not use(4,8),ttime(X2),vehicleId(X3),vehicleType(X1).



clauseIndex(1..4).

literalIndex(0..9).

{use(1,1..8)}.{use(2,1..8)}.{use(3,1..8)}.{use(4,1..8)}.



{use(I,J)}:-clauseIndex(I),literalIndex(J).

{use(I,J,K)}:-clauseIndex(I),clauseIndex(J),literalIndex(K).

#minimize{use(I,J),use(I,J,K)}.

:- use(I,J), not use(I,0).

#hide.

#show use/2.

#show use/3.