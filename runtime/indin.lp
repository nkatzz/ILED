

initiatedAt(driving_style(X3,X1,unsafe),X2) :- initiatedAt(sharp_turn(X3,X1,very_sharp),X2),not expt(1,initiatedAt(driving_style(X3,X1,unsafe),X2)),ttime(X2),vehicleId(X3),vehicleType(X1).
expt(1,initiatedAt(driving_style(X3,X1,unsafe),X2)) :- use(1,1,1),not not_holdsAt(sharp_turn(X3,X1,very_sharp),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
expt(1,initiatedAt(driving_style(X3,X1,unsafe),X2)) :- use(1,1,2),not not_holdsAt(sharp_turn(X3,X1,sharp),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
expt(1,initiatedAt(driving_style(X3,X1,unsafe),X2)) :- use(1,1,3),not not_holdsAt(abrupt_acceleration(X3,X1,very_abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
expt(1,initiatedAt(driving_style(X3,X1,unsafe),X2)) :- use(1,1,4),not not_holdsAt(abrupt_acceleration(X3,X1,abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
expt(1,initiatedAt(driving_style(X3,X1,unsafe),X2)) :- use(1,1,5),not not_holdsAt(abrupt_deceleration(X3,X1,very_abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
expt(1,initiatedAt(driving_style(X3,X1,unsafe),X2)) :- use(1,1,6),not not_holdsAt(abrupt_deceleration(X3,X1,abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
initiatedAt(driving_style(X3,X1,unsafe),X2) :- initiatedAt(sharp_turn(X3,X1,very_sharp),X2),not expt(1,initiatedAt(driving_style(X3,X1,unsafe),X2)),ttime(X2),vehicleId(X3),vehicleType(X1).
expt(1,initiatedAt(driving_style(X3,X1,unsafe),X2)) :- use(1,2,1),not initiatedAt(abrupt_deceleration(X3,X1,abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
expt(1,initiatedAt(driving_style(X3,X1,unsafe),X2)) :- use(1,2,2),not holdsAt(abrupt_acceleration(X3,X1,abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
expt(1,initiatedAt(driving_style(X3,X1,unsafe),X2)) :- use(1,2,3),not not_holdsAt(sharp_turn(X3,X1,very_sharp),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
expt(1,initiatedAt(driving_style(X3,X1,unsafe),X2)) :- use(1,2,4),not not_holdsAt(sharp_turn(X3,X1,sharp),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
expt(1,initiatedAt(driving_style(X3,X1,unsafe),X2)) :- use(1,2,5),not not_holdsAt(abrupt_acceleration(X3,X1,very_abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
expt(1,initiatedAt(driving_style(X3,X1,unsafe),X2)) :- use(1,2,6),not not_holdsAt(abrupt_deceleration(X3,X1,very_abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
expt(1,initiatedAt(driving_style(X3,X1,unsafe),X2)) :- use(1,2,7),not not_holdsAt(abrupt_deceleration(X3,X1,abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
initiatedAt(driving_style(X3,X1,unsafe),X2) :- initiatedAt(sharp_turn(X3,X1,very_sharp),X2),not expt(1,initiatedAt(driving_style(X3,X1,unsafe),X2)),ttime(X2),vehicleId(X3),vehicleType(X1).
expt(1,initiatedAt(driving_style(X3,X1,unsafe),X2)) :- use(1,3,1),not initiatedAt(sharp_turn(X2,X1,very_sharp),X3),vehicleId(X2),ttime(X3),vehicleType(X1),ttime(X2),vehicleId(X3).
expt(1,initiatedAt(driving_style(X3,X1,unsafe),X2)) :- use(1,3,2),not holdsAt(abrupt_deceleration(X2,X1,abrupt),X3),vehicleId(X2),ttime(X3),vehicleType(X1),ttime(X2),vehicleId(X3).
expt(1,initiatedAt(driving_style(X3,X1,unsafe),X2)) :- use(1,3,3),not holdsAt(abrupt_acceleration(X2,X1,abrupt),X3),vehicleId(X2),ttime(X3),vehicleType(X1),ttime(X2),vehicleId(X3).
expt(1,initiatedAt(driving_style(X3,X1,unsafe),X2)) :- use(1,3,4),not not_holdsAt(sharp_turn(X2,X1,very_sharp),X3),vehicleId(X2),ttime(X3),vehicleType(X1),ttime(X2),vehicleId(X3).
expt(1,initiatedAt(driving_style(X3,X1,unsafe),X2)) :- use(1,3,5),not not_holdsAt(sharp_turn(X2,X1,sharp),X3),vehicleId(X2),ttime(X3),vehicleType(X1),ttime(X2),vehicleId(X3).
expt(1,initiatedAt(driving_style(X3,X1,unsafe),X2)) :- use(1,3,6),not not_holdsAt(abrupt_acceleration(X2,X1,very_abrupt),X3),vehicleId(X2),ttime(X3),vehicleType(X1),ttime(X2),vehicleId(X3).
expt(1,initiatedAt(driving_style(X3,X1,unsafe),X2)) :- use(1,3,7),not not_holdsAt(abrupt_deceleration(X2,X1,very_abrupt),X3),vehicleId(X2),ttime(X3),vehicleType(X1),ttime(X2),vehicleId(X3).
terminatedAt(driving_style(X3,X1,unsafe),X2) :- terminatedAt(sharp_turn(X3,X1,very_sharp),X2),holdsAt(abrupt_acceleration(X3,X1,abrupt),X2),not expt(2,terminatedAt(driving_style(X3,X1,unsafe),X2)),ttime(X2),vehicleId(X3),vehicleType(X1).
expt(2,terminatedAt(driving_style(X3,X1,unsafe),X2)) :- use(2,1,1),not holdsAt(sharp_turn(X3,X1,very_sharp),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
expt(2,terminatedAt(driving_style(X3,X1,unsafe),X2)) :- use(2,1,2),not holdsAt(abrupt_deceleration(X3,X1,abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
expt(2,terminatedAt(driving_style(X3,X1,unsafe),X2)) :- use(2,1,3),not not_holdsAt(sharp_turn(X3,X1,sharp),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
expt(2,terminatedAt(driving_style(X3,X1,unsafe),X2)) :- use(2,1,4),not not_holdsAt(abrupt_acceleration(X3,X1,very_abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
expt(2,terminatedAt(driving_style(X3,X1,unsafe),X2)) :- use(2,1,5),not not_holdsAt(abrupt_deceleration(X3,X1,very_abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
terminatedAt(driving_style(X3,X1,unsafe),X2) :- terminatedAt(sharp_turn(X3,X1,very_sharp),X2),holdsAt(abrupt_acceleration(X3,X1,abrupt),X2),not expt(2,terminatedAt(driving_style(X3,X1,unsafe),X2)),ttime(X2),vehicleId(X3),vehicleType(X1).
expt(2,terminatedAt(driving_style(X3,X1,unsafe),X2)) :- use(2,2,1),not terminatedAt(sharp_turn(X3,X2,very_sharp),X1),vehicleType(X2),vehicleId(X3),ttime(X1),ttime(X2),vehicleType(X1).
expt(2,terminatedAt(driving_style(X3,X1,unsafe),X2)) :- use(2,2,2),not terminatedAt(abrupt_acceleration(X3,X2,abrupt),X1),vehicleType(X2),vehicleId(X3),ttime(X1),ttime(X2),vehicleType(X1).
expt(2,terminatedAt(driving_style(X3,X1,unsafe),X2)) :- use(2,2,3),not holdsAt(abrupt_acceleration(X3,X2,abrupt),X1),vehicleType(X2),vehicleId(X3),ttime(X1),ttime(X2),vehicleType(X1).
expt(2,terminatedAt(driving_style(X3,X1,unsafe),X2)) :- use(2,2,4),not holdsAt(sharp_turn(X3,X2,very_sharp),X1),vehicleType(X2),vehicleId(X3),ttime(X1),ttime(X2),vehicleType(X1).
expt(2,terminatedAt(driving_style(X3,X1,unsafe),X2)) :- use(2,2,5),not not_holdsAt(sharp_turn(X3,X2,sharp),X1),vehicleType(X2),vehicleId(X3),ttime(X1),ttime(X2),vehicleType(X1).
expt(2,terminatedAt(driving_style(X3,X1,unsafe),X2)) :- use(2,2,6),not not_holdsAt(abrupt_acceleration(X3,X2,very_abrupt),X1),vehicleType(X2),vehicleId(X3),ttime(X1),ttime(X2),vehicleType(X1).
expt(2,terminatedAt(driving_style(X3,X1,unsafe),X2)) :- use(2,2,7),not not_holdsAt(abrupt_deceleration(X3,X2,very_abrupt),X1),vehicleType(X2),vehicleId(X3),ttime(X1),ttime(X2),vehicleType(X1).
expt(2,terminatedAt(driving_style(X3,X1,unsafe),X2)) :- use(2,2,8),not not_holdsAt(abrupt_deceleration(X3,X2,abrupt),X1),vehicleType(X2),vehicleId(X3),ttime(X1),ttime(X2),vehicleType(X1).
initiatedAt(driving_style(X3,X1,unsafe),X2) :- initiatedAt(abrupt_deceleration(X3,X1,very_abrupt),X2),not expt(3,initiatedAt(driving_style(X3,X1,unsafe),X2)),ttime(X2),vehicleId(X3),vehicleType(X1).
expt(3,initiatedAt(driving_style(X3,X1,unsafe),X2)) :- use(3,1,1),not initiatedAt(abrupt_acceleration(X3,X1,abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
expt(3,initiatedAt(driving_style(X3,X1,unsafe),X2)) :- use(3,1,2),not not_holdsAt(sharp_turn(X3,X1,very_sharp),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
expt(3,initiatedAt(driving_style(X3,X1,unsafe),X2)) :- use(3,1,3),not not_holdsAt(sharp_turn(X3,X1,sharp),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
expt(3,initiatedAt(driving_style(X3,X1,unsafe),X2)) :- use(3,1,4),not not_holdsAt(abrupt_acceleration(X3,X1,very_abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
expt(3,initiatedAt(driving_style(X3,X1,unsafe),X2)) :- use(3,1,5),not not_holdsAt(abrupt_acceleration(X3,X1,abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
expt(3,initiatedAt(driving_style(X3,X1,unsafe),X2)) :- use(3,1,6),not not_holdsAt(abrupt_deceleration(X3,X1,very_abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
expt(3,initiatedAt(driving_style(X3,X1,unsafe),X2)) :- use(3,1,7),not not_holdsAt(abrupt_deceleration(X3,X1,abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
initiatedAt(driving_style(X3,X1,unsafe),X2) :- initiatedAt(abrupt_deceleration(X3,X1,very_abrupt),X2),not expt(3,initiatedAt(driving_style(X3,X1,unsafe),X2)),ttime(X2),vehicleId(X3),vehicleType(X1).
expt(3,initiatedAt(driving_style(X3,X1,unsafe),X2)) :- use(3,2,1),not initiatedAt(abrupt_deceleration(X2,X1,very_abrupt),X3),vehicleId(X2),ttime(X3),vehicleType(X1),ttime(X2),vehicleId(X3).
expt(3,initiatedAt(driving_style(X3,X1,unsafe),X2)) :- use(3,2,2),not holdsAt(abrupt_acceleration(X2,X1,abrupt),X3),vehicleId(X2),ttime(X3),vehicleType(X1),ttime(X2),vehicleId(X3).
expt(3,initiatedAt(driving_style(X3,X1,unsafe),X2)) :- use(3,2,3),not not_holdsAt(sharp_turn(X2,X1,very_sharp),X3),vehicleId(X2),ttime(X3),vehicleType(X1),ttime(X2),vehicleId(X3).
expt(3,initiatedAt(driving_style(X3,X1,unsafe),X2)) :- use(3,2,4),not not_holdsAt(sharp_turn(X2,X1,sharp),X3),vehicleId(X2),ttime(X3),vehicleType(X1),ttime(X2),vehicleId(X3).
expt(3,initiatedAt(driving_style(X3,X1,unsafe),X2)) :- use(3,2,5),not not_holdsAt(abrupt_acceleration(X2,X1,very_abrupt),X3),vehicleId(X2),ttime(X3),vehicleType(X1),ttime(X2),vehicleId(X3).
expt(3,initiatedAt(driving_style(X3,X1,unsafe),X2)) :- use(3,2,6),not not_holdsAt(abrupt_deceleration(X2,X1,very_abrupt),X3),vehicleId(X2),ttime(X3),vehicleType(X1),ttime(X2),vehicleId(X3).
expt(3,initiatedAt(driving_style(X3,X1,unsafe),X2)) :- use(3,2,7),not not_holdsAt(abrupt_deceleration(X2,X1,abrupt),X3),vehicleId(X2),ttime(X3),vehicleType(X1),ttime(X2),vehicleId(X3).
terminatedAt(driving_style(X3,X1,unsafe),X2) :- terminatedAt(sharp_turn(X3,X1,sharp),X2),terminatedAt(abrupt_acceleration(X3,X1,very_abrupt),X2),not expt(4,terminatedAt(driving_style(X3,X1,unsafe),X2)),ttime(X2),vehicleId(X3),vehicleType(X1).
expt(4,terminatedAt(driving_style(X3,X1,unsafe),X2)) :- use(4,1,1),not holdsAt(sharp_turn(X3,X1,sharp),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
expt(4,terminatedAt(driving_style(X3,X1,unsafe),X2)) :- use(4,1,2),not holdsAt(abrupt_acceleration(X3,X1,very_abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
expt(4,terminatedAt(driving_style(X3,X1,unsafe),X2)) :- use(4,1,3),not not_holdsAt(sharp_turn(X3,X1,very_sharp),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
expt(4,terminatedAt(driving_style(X3,X1,unsafe),X2)) :- use(4,1,4),not not_holdsAt(abrupt_acceleration(X3,X1,abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
expt(4,terminatedAt(driving_style(X3,X1,unsafe),X2)) :- use(4,1,5),not not_holdsAt(abrupt_deceleration(X3,X1,very_abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
expt(4,terminatedAt(driving_style(X3,X1,unsafe),X2)) :- use(4,1,6),not not_holdsAt(abrupt_deceleration(X3,X1,abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
terminatedAt(driving_style(X2,X1,unsafe),X3) :- terminatedAt(abrupt_deceleration(X2,X1,very_abrupt),X3),not_holdsAt(abrupt_acceleration(X2,X1,very_abrupt),X3),not_holdsAt(sharp_turn(X2,X1,very_sharp),X3),not expt(5,terminatedAt(driving_style(X2,X1,unsafe),X3)),vehicleId(X2),ttime(X3),vehicleType(X1).
expt(5,terminatedAt(driving_style(X2,X1,unsafe),X3)) :- use(5,1,1),not holdsAt(abrupt_deceleration(X2,X1,very_abrupt),X3),vehicleId(X2),ttime(X3),vehicleType(X1).
expt(5,terminatedAt(driving_style(X2,X1,unsafe),X3)) :- use(5,1,2),not not_holdsAt(sharp_turn(X2,X1,sharp),X3),vehicleId(X2),ttime(X3),vehicleType(X1).
expt(5,terminatedAt(driving_style(X2,X1,unsafe),X3)) :- use(5,1,3),not not_holdsAt(abrupt_acceleration(X2,X1,abrupt),X3),vehicleId(X2),ttime(X3),vehicleType(X1).
expt(5,terminatedAt(driving_style(X2,X1,unsafe),X3)) :- use(5,1,4),not not_holdsAt(abrupt_deceleration(X2,X1,abrupt),X3),vehicleId(X2),ttime(X3),vehicleType(X1).
initiatedAt(driving_style(X2,X1,unsafe),X3) :- initiatedAt(abrupt_acceleration(X2,X1,very_abrupt),X3),not expt(6,initiatedAt(driving_style(X2,X1,unsafe),X3)),vehicleId(X2),ttime(X3),vehicleType(X1).
expt(6,initiatedAt(driving_style(X2,X1,unsafe),X3)) :- use(6,1,1),not initiatedAt(sharp_turn(X2,X1,sharp),X3),vehicleId(X2),ttime(X3),vehicleType(X1).
expt(6,initiatedAt(driving_style(X2,X1,unsafe),X3)) :- use(6,1,2),not holdsAt(abrupt_deceleration(X2,X1,abrupt),X3),vehicleId(X2),ttime(X3),vehicleType(X1).
expt(6,initiatedAt(driving_style(X2,X1,unsafe),X3)) :- use(6,1,3),not not_holdsAt(sharp_turn(X2,X1,very_sharp),X3),vehicleId(X2),ttime(X3),vehicleType(X1).
expt(6,initiatedAt(driving_style(X2,X1,unsafe),X3)) :- use(6,1,4),not not_holdsAt(sharp_turn(X2,X1,sharp),X3),vehicleId(X2),ttime(X3),vehicleType(X1).
expt(6,initiatedAt(driving_style(X2,X1,unsafe),X3)) :- use(6,1,5),not not_holdsAt(abrupt_acceleration(X2,X1,very_abrupt),X3),vehicleId(X2),ttime(X3),vehicleType(X1).
expt(6,initiatedAt(driving_style(X2,X1,unsafe),X3)) :- use(6,1,6),not not_holdsAt(abrupt_acceleration(X2,X1,abrupt),X3),vehicleId(X2),ttime(X3),vehicleType(X1).
expt(6,initiatedAt(driving_style(X2,X1,unsafe),X3)) :- use(6,1,7),not not_holdsAt(abrupt_deceleration(X2,X1,very_abrupt),X3),vehicleId(X2),ttime(X3),vehicleType(X1).
initiatedAt(driving_style(X2,X1,unsafe),X3) :- initiatedAt(abrupt_acceleration(X2,X1,very_abrupt),X3),not expt(6,initiatedAt(driving_style(X2,X1,unsafe),X3)),vehicleId(X2),ttime(X3),vehicleType(X1).
expt(6,initiatedAt(driving_style(X2,X1,unsafe),X3)) :- use(6,2,1),not initiatedAt(abrupt_acceleration(X3,X1,very_abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1),vehicleId(X2),ttime(X3).
expt(6,initiatedAt(driving_style(X2,X1,unsafe),X3)) :- use(6,2,2),not not_holdsAt(sharp_turn(X3,X1,very_sharp),X2),ttime(X2),vehicleId(X3),vehicleType(X1),vehicleId(X2),ttime(X3).
expt(6,initiatedAt(driving_style(X2,X1,unsafe),X3)) :- use(6,2,3),not not_holdsAt(sharp_turn(X3,X1,sharp),X2),ttime(X2),vehicleId(X3),vehicleType(X1),vehicleId(X2),ttime(X3).
expt(6,initiatedAt(driving_style(X2,X1,unsafe),X3)) :- use(6,2,4),not not_holdsAt(abrupt_acceleration(X3,X1,very_abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1),vehicleId(X2),ttime(X3).
expt(6,initiatedAt(driving_style(X2,X1,unsafe),X3)) :- use(6,2,5),not not_holdsAt(abrupt_acceleration(X3,X1,abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1),vehicleId(X2),ttime(X3).
expt(6,initiatedAt(driving_style(X2,X1,unsafe),X3)) :- use(6,2,6),not not_holdsAt(abrupt_deceleration(X3,X1,very_abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1),vehicleId(X2),ttime(X3).
expt(6,initiatedAt(driving_style(X2,X1,unsafe),X3)) :- use(6,2,7),not not_holdsAt(abrupt_deceleration(X3,X1,abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1),vehicleId(X2),ttime(X3).
terminatedAt(driving_style(X3,X1,unsafe),X2) :- terminatedAt(sharp_turn(X3,X1,very_sharp),X2),not_holdsAt(abrupt_acceleration(X3,X1,very_abrupt),X2),not_holdsAt(abrupt_deceleration(X3,X1,very_abrupt),X2),not expt(7,terminatedAt(driving_style(X3,X1,unsafe),X2)),ttime(X2),vehicleId(X3),vehicleType(X1).
expt(7,terminatedAt(driving_style(X3,X1,unsafe),X2)) :- use(7,1,1),not holdsAt(sharp_turn(X3,X1,very_sharp),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
expt(7,terminatedAt(driving_style(X3,X1,unsafe),X2)) :- use(7,1,2),not not_holdsAt(sharp_turn(X3,X1,sharp),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
expt(7,terminatedAt(driving_style(X3,X1,unsafe),X2)) :- use(7,1,3),not not_holdsAt(abrupt_acceleration(X3,X1,abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
expt(7,terminatedAt(driving_style(X3,X1,unsafe),X2)) :- use(7,1,4),not not_holdsAt(abrupt_deceleration(X3,X1,abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
terminatedAt(driving_style(X3,X1,unsafe),X2) :- terminatedAt(abrupt_acceleration(X3,X1,very_abrupt),X2),not_holdsAt(abrupt_deceleration(X3,X1,very_abrupt),X2),not expt(8,terminatedAt(driving_style(X3,X1,unsafe),X2)),ttime(X2),vehicleId(X3),vehicleType(X1).
expt(8,terminatedAt(driving_style(X3,X1,unsafe),X2)) :- use(8,1,1),not holdsAt(abrupt_acceleration(X3,X1,very_abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
expt(8,terminatedAt(driving_style(X3,X1,unsafe),X2)) :- use(8,1,2),not holdsAt(abrupt_deceleration(X3,X1,abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
expt(8,terminatedAt(driving_style(X3,X1,unsafe),X2)) :- use(8,1,3),not not_holdsAt(sharp_turn(X3,X1,very_sharp),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
expt(8,terminatedAt(driving_style(X3,X1,unsafe),X2)) :- use(8,1,4),not not_holdsAt(sharp_turn(X3,X1,sharp),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
expt(8,terminatedAt(driving_style(X3,X1,unsafe),X2)) :- use(8,1,5),not not_holdsAt(abrupt_acceleration(X3,X1,abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).

clauseIndex(1..8).

literalIndex(0..9).



{use(1,1,1..7)}.{use(1,2,1..8)}.{use(1,3,1..7)}.{use(2,1,1..7)}.{use(2,2,1..8)}.{use(3,1,1..8)}.{use(3,2,1..7)}.{use(4,1,1..8)}.{use(5,1,1..7)}.{use(6,1,1..8)}.{use(6,2,1..7)}.{use(7,1,1..7)}.{use(8,1,1..7)}.

{use(I,J)}:-clauseIndex(I),literalIndex(J).

{use(I,J,K)}:-clauseIndex(I),clauseIndex(J),literalIndex(K).

#minimize{use(I,J),use(I,J,K)}.

:- use(I,J), not use(I,0).

#hide.

#show use/2.

#show use/3.