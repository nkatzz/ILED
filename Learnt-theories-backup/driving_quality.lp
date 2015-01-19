terminatedAt(driving_quality(X3,X1,low),X2) :- 
        holdsAt(abrupt_deceleration(X3,X1,very_abrupt),X2),
        happensAt(my_stop_enter(X3,X1,stopId,scheduled),X2).
initiatedAt(driving_quality(X2,X1,low),X3) :- 
        terminatedAt(punctuality(X2,X1,punctual),X3),
        not_holdsAt(punctuality(X2,X1,non_punctual),X3),
        not_happensAt(abrupt_deceleration_end(X2,X1,very_abrupt),X3),
        happensAt(my_stop_enter(X2,X1,stopId,late),X3),
        holdsAt(abrupt_deceleration(X2,X1,very_abrupt),X3).
terminatedAt(driving_quality(X3,X1,low),X2) :- 
        holdsAt(sharp_turn(X3,X1,sharp),X2),
        happensAt(my_stop_enter(X3,X1,stopId,scheduled),X2).
initiatedAt(driving_quality(X3,X1,low),X2) :- 
        happensAt(my_stop_leave(X3,X1,stopId,early),X2),
        holdsAt(sharp_turn(X3,X1,very_sharp),X2).
initiatedAt(driving_quality(X2,X1,low),X3) :- 
        happensAt(my_stop_leave(X2,X1,stopId,early),X3),
        happensAt(abrupt_deceleration_end(X2,X1,very_abrupt),X3).
terminatedAt(driving_quality(X3,X1,low),X2) :- 
        initiatedAt(punctuality(X3,X1,punctual),X2),
        not_happensAt(sharp_turn_start(X3,X1,sharp),X2).
terminatedAt(driving_quality(X3,X1,low),X2) :- 
        terminatedAt(driving_style(X3,X1,unsafe),X2).
initiatedAt(driving_quality(X3,X1,low),X2) :- 
        happensAt(sharp_turn_start(X3,X1,very_sharp),X2),
        not_holdsAt(punctuality(X3,X1,punctual),X2),
        happensAt(abrupt_deceleration_start(X3,X1,abrupt),X2).
initiatedAt(driving_quality(X3,X1,low),X2) :- 
        initiatedAt(driving_style(X3,X1,unsafe),X2),
        not_holdsAt(punctuality(X3,X1,punctual),X2),
        holdsAt(punctuality(X3,X1,non_punctual),X2),
        not_happensAt(my_stop_enter(X3,X1,stopId,scheduled),X2),
        not_happensAt(my_stop_enter(X3,X1,stopId,early),X2).
initiatedAt(driving_quality(X3,X2,low),X1) :- 
        initiatedAt(punctuality(X3,X2,non_punctual),X1),
        holdsAt(abrupt_acceleration(X3,X2,abrupt),X1),
        not_holdsAt(punctuality(X3,X2,non_punctual),X1).



