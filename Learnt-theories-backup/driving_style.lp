initiatedAt(driving_style(X2,X1,unsafe),X3) :- 
        happensAt(abrupt_acceleration_start(X2,X1,very_abrupt),X3),
        not_holdsAt(sharp_turn(X2,X1,very_sharp),X3).
terminatedAt(driving_style(X3,X2,unsafe),X1) :- 
        happensAt(abrupt_deceleration_end(X3,X2,very_abrupt),X1),
        not_holdsAt(abrupt_acceleration(X3,X2,very_abrupt),X1),
        not_holdsAt(sharp_turn(X3,X2,very_sharp),X1),
        not_happensAt(abrupt_acceleration_start(X3,X2,very_abrupt),X1).
terminatedAt(driving_style(X3,X1,unsafe),X2) :- 
        happensAt(sharp_turn_end(X3,X1,very_sharp),X2),
        not_holdsAt(abrupt_acceleration(X3,X1,very_abrupt),X2),
        not_holdsAt(abrupt_deceleration(X3,X1,very_abrupt),X2),
        not_happensAt(abrupt_deceleration_start(X3,X1,very_abrupt),X2).
initiatedAt(driving_style(X3,X1,unsafe),X2) :- 
        happensAt(abrupt_deceleration_start(X3,X1,very_abrupt),X2),
        not_holdsAt(sharp_turn(X3,X1,very_sharp),X2).
initiatedAt(driving_style(X3,X1,unsafe),X2) :- 
        happensAt(sharp_turn_start(X3,X1,very_sharp),X2).
terminatedAt(driving_style(X3,X1,unsafe),X2) :- 
        happensAt(abrupt_acceleration_end(X3,X1,very_abrupt),X2),
        not_happensAt(abrupt_deceleration_end(X3,X1,very_abrupt),X2),
        not_holdsAt(sharp_turn(X3,X1,very_sharp),X2),
        not_happensAt(sharp_turn_start(X3,X1,very_sharp),X2),
        not_holdsAt(abrupt_deceleration(X3,X1,very_abrupt),X2),
        not_happensAt(abrupt_deceleration_start(X3,X1,very_abrupt),X2).
