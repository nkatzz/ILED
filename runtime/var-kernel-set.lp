initiatedAt(punctuality(X3,X1,punctual),X2) :- 
        initiatedAt(punctuality(X3,X1,punctual),X2),
        terminatedAt(punctuality(X3,X1,non_punctual),X2),
        happensAt(my_stop_enter(X3,X1,stopId,early),X2),
        not_happensAt(my_stop_enter(X3,X1,stopId,scheduled),X2),
        not_happensAt(my_stop_enter(X3,X1,stopId,late),X2),
        not_happensAt(my_stop_leave(X3,X1,stopId,scheduled),X2),
        not_happensAt(my_stop_leave(X3,X1,stopId,early),X2),
        not_happensAt(my_stop_leave(X3,X1,stopId,late),X2).

initiatedAt(punctuality(X3,X1,non_punctual),X2) :- 
        initiatedAt(punctuality(X3,X1,non_punctual),X2),
        terminatedAt(punctuality(X3,X1,punctual),X2),
        happensAt(my_stop_enter(X3,X1,stopId,late),X2),
        not_happensAt(my_stop_enter(X3,X1,stopId,scheduled),X2),
        not_happensAt(my_stop_enter(X3,X1,stopId,early),X2),
        not_happensAt(my_stop_leave(X3,X1,stopId,scheduled),X2),
        not_happensAt(my_stop_leave(X3,X1,stopId,early),X2),
        not_happensAt(my_stop_leave(X3,X1,stopId,late),X2).

terminatedAt(punctuality(X3,X1,non_punctual),X2) :- 
        initiatedAt(punctuality(X3,X1,punctual),X2),
        terminatedAt(punctuality(X3,X1,non_punctual),X2),
        happensAt(my_stop_enter(X3,X1,stopId,early),X2),
        not_happensAt(my_stop_enter(X3,X1,stopId,scheduled),X2),
        not_happensAt(my_stop_enter(X3,X1,stopId,late),X2),
        not_happensAt(my_stop_leave(X3,X1,stopId,scheduled),X2),
        not_happensAt(my_stop_leave(X3,X1,stopId,early),X2),
        not_happensAt(my_stop_leave(X3,X1,stopId,late),X2).

terminatedAt(punctuality(X3,X1,punctual),X2) :- 
        initiatedAt(punctuality(X3,X1,non_punctual),X2),
        terminatedAt(punctuality(X3,X1,punctual),X2),
        happensAt(my_stop_enter(X3,X1,stopId,late),X2),
        not_happensAt(my_stop_enter(X3,X1,stopId,scheduled),X2),
        not_happensAt(my_stop_enter(X3,X1,stopId,early),X2),
        not_happensAt(my_stop_leave(X3,X1,stopId,scheduled),X2),
        not_happensAt(my_stop_leave(X3,X1,stopId,early),X2),
        not_happensAt(my_stop_leave(X3,X1,stopId,late),X2).