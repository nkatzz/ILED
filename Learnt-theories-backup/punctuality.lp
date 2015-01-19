terminatedAt(punctuality(X3,X1,non_punctual),X2) :- 
        happensAt(my_stop_enter(X3,X1,stopId,early),X2).
initiatedAt(punctuality(X3,X1,punctual),X2) :- 
        happensAt(my_stop_enter(X3,X1,stopId,early),X2).
terminatedAt(punctuality(X3,X1,non_punctual),X2) :- 
        happensAt(my_stop_enter(X3,X1,stopId,scheduled),X2).
terminatedAt(punctuality(X2,X1,punctual),X3) :- 
        happensAt(my_stop_enter(X2,X1,stopId,late),X3).
initiatedAt(punctuality(X3,X1,non_punctual),X2) :- 
        happensAt(my_stop_leave(X3,X1,stopId,early),X2).
initiatedAt(punctuality(X2,X1,non_punctual),X3) :- 
        happensAt(my_stop_enter(X2,X1,stopId,late),X3).
terminatedAt(punctuality(X3,X1,punctual),X2) :- 
        happensAt(my_stop_leave(X3,X1,stopId,early),X2).
initiatedAt(punctuality(X3,X1,punctual),X2) :- 
        happensAt(my_stop_enter(X3,X1,stopId,scheduled),X2).
