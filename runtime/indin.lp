initiatedAt(driving_style(X3,X1,unsafe),X2) :- use(1,0),try(1,1,vars(X2,X3,X1)),try(1,2,vars(X2,X3,X1)),try(1,3,vars(X2,X3,X1)),try(1,4,vars(X2,X3,X1)),try(1,5,vars(X2,X3,X1)),try(1,6,vars(X2,X3,X1)),try(1,7,vars(X2,X3,X1)),try(1,8,vars(X2,X3,X1)),ttime(X2),vehicleId(X3),vehicleType(X1).
try(1,1,vars(X2,X3,X1)) :- use(1,1),initiatedAt(abrupt_acceleration(X3,X1,very_abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(1,1,vars(X2,X3,X1)) :- not use(1,1),ttime(X2),vehicleId(X3),vehicleType(X1).
try(1,2,vars(X2,X3,X1)) :- use(1,2),initiatedAt(abrupt_deceleration(X3,X1,abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(1,2,vars(X2,X3,X1)) :- not use(1,2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(1,3,vars(X2,X3,X1)) :- use(1,3),not_holdsAt(sharp_turn(X3,X1,very_sharp),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(1,3,vars(X2,X3,X1)) :- not use(1,3),ttime(X2),vehicleId(X3),vehicleType(X1).
try(1,4,vars(X2,X3,X1)) :- use(1,4),not_holdsAt(sharp_turn(X3,X1,sharp),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(1,4,vars(X2,X3,X1)) :- not use(1,4),ttime(X2),vehicleId(X3),vehicleType(X1).
try(1,5,vars(X2,X3,X1)) :- use(1,5),not_holdsAt(abrupt_acceleration(X3,X1,very_abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(1,5,vars(X2,X3,X1)) :- not use(1,5),ttime(X2),vehicleId(X3),vehicleType(X1).
try(1,6,vars(X2,X3,X1)) :- use(1,6),not_holdsAt(abrupt_acceleration(X3,X1,abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(1,6,vars(X2,X3,X1)) :- not use(1,6),ttime(X2),vehicleId(X3),vehicleType(X1).
try(1,7,vars(X2,X3,X1)) :- use(1,7),not_holdsAt(abrupt_deceleration(X3,X1,very_abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(1,7,vars(X2,X3,X1)) :- not use(1,7),ttime(X2),vehicleId(X3),vehicleType(X1).
try(1,8,vars(X2,X3,X1)) :- use(1,8),not_holdsAt(abrupt_deceleration(X3,X1,abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(1,8,vars(X2,X3,X1)) :- not use(1,8),ttime(X2),vehicleId(X3),vehicleType(X1).
initiatedAt(driving_style(X3,X1,unsafe),X2) :- use(2,0),try(2,1,vars(X2,X3,X1)),try(2,2,vars(X2,X3,X1)),try(2,3,vars(X2,X3,X1)),try(2,4,vars(X2,X3,X1)),try(2,5,vars(X2,X3,X1)),try(2,6,vars(X2,X3,X1)),try(2,7,vars(X2,X3,X1)),ttime(X2),vehicleId(X3),vehicleType(X1).
try(2,1,vars(X2,X3,X1)) :- use(2,1),initiatedAt(abrupt_deceleration(X3,X1,very_abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(2,1,vars(X2,X3,X1)) :- not use(2,1),ttime(X2),vehicleId(X3),vehicleType(X1).
try(2,2,vars(X2,X3,X1)) :- use(2,2),not_holdsAt(sharp_turn(X3,X1,very_sharp),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(2,2,vars(X2,X3,X1)) :- not use(2,2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(2,3,vars(X2,X3,X1)) :- use(2,3),not_holdsAt(sharp_turn(X3,X1,sharp),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(2,3,vars(X2,X3,X1)) :- not use(2,3),ttime(X2),vehicleId(X3),vehicleType(X1).
try(2,4,vars(X2,X3,X1)) :- use(2,4),not_holdsAt(abrupt_acceleration(X3,X1,very_abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(2,4,vars(X2,X3,X1)) :- not use(2,4),ttime(X2),vehicleId(X3),vehicleType(X1).
try(2,5,vars(X2,X3,X1)) :- use(2,5),not_holdsAt(abrupt_acceleration(X3,X1,abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(2,5,vars(X2,X3,X1)) :- not use(2,5),ttime(X2),vehicleId(X3),vehicleType(X1).
try(2,6,vars(X2,X3,X1)) :- use(2,6),not_holdsAt(abrupt_deceleration(X3,X1,very_abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(2,6,vars(X2,X3,X1)) :- not use(2,6),ttime(X2),vehicleId(X3),vehicleType(X1).
try(2,7,vars(X2,X3,X1)) :- use(2,7),not_holdsAt(abrupt_deceleration(X3,X1,abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(2,7,vars(X2,X3,X1)) :- not use(2,7),ttime(X2),vehicleId(X3),vehicleType(X1).
initiatedAt(driving_style(X3,X1,unsafe),X2) :- use(3,0),try(3,1,vars(X2,X3,X1)),try(3,2,vars(X2,X3,X1)),try(3,3,vars(X2,X3,X1)),try(3,4,vars(X2,X3,X1)),try(3,5,vars(X2,X3,X1)),try(3,6,vars(X2,X3,X1)),try(3,7,vars(X2,X3,X1)),ttime(X2),vehicleId(X3),vehicleType(X1).
try(3,1,vars(X2,X3,X1)) :- use(3,1),initiatedAt(abrupt_acceleration(X3,X1,very_abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(3,1,vars(X2,X3,X1)) :- not use(3,1),ttime(X2),vehicleId(X3),vehicleType(X1).
try(3,2,vars(X2,X3,X1)) :- use(3,2),not_holdsAt(sharp_turn(X3,X1,very_sharp),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(3,2,vars(X2,X3,X1)) :- not use(3,2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(3,3,vars(X2,X3,X1)) :- use(3,3),not_holdsAt(sharp_turn(X3,X1,sharp),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(3,3,vars(X2,X3,X1)) :- not use(3,3),ttime(X2),vehicleId(X3),vehicleType(X1).
try(3,4,vars(X2,X3,X1)) :- use(3,4),not_holdsAt(abrupt_acceleration(X3,X1,very_abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(3,4,vars(X2,X3,X1)) :- not use(3,4),ttime(X2),vehicleId(X3),vehicleType(X1).
try(3,5,vars(X2,X3,X1)) :- use(3,5),not_holdsAt(abrupt_acceleration(X3,X1,abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(3,5,vars(X2,X3,X1)) :- not use(3,5),ttime(X2),vehicleId(X3),vehicleType(X1).
try(3,6,vars(X2,X3,X1)) :- use(3,6),not_holdsAt(abrupt_deceleration(X3,X1,very_abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(3,6,vars(X2,X3,X1)) :- not use(3,6),ttime(X2),vehicleId(X3),vehicleType(X1).
try(3,7,vars(X2,X3,X1)) :- use(3,7),not_holdsAt(abrupt_deceleration(X3,X1,abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(3,7,vars(X2,X3,X1)) :- not use(3,7),ttime(X2),vehicleId(X3),vehicleType(X1).
initiatedAt(driving_style(X3,X1,unsafe),X2) :- use(4,0),try(4,1,vars(X2,X3,X1)),try(4,2,vars(X2,X3,X1)),try(4,3,vars(X2,X3,X1)),try(4,4,vars(X2,X3,X1)),try(4,5,vars(X2,X3,X1)),try(4,6,vars(X2,X3,X1)),try(4,7,vars(X2,X3,X1)),ttime(X2),vehicleId(X3),vehicleType(X1).
try(4,1,vars(X2,X3,X1)) :- use(4,1),initiatedAt(abrupt_deceleration(X3,X1,very_abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(4,1,vars(X2,X3,X1)) :- not use(4,1),ttime(X2),vehicleId(X3),vehicleType(X1).
try(4,2,vars(X2,X3,X1)) :- use(4,2),not_holdsAt(sharp_turn(X3,X1,very_sharp),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(4,2,vars(X2,X3,X1)) :- not use(4,2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(4,3,vars(X2,X3,X1)) :- use(4,3),not_holdsAt(sharp_turn(X3,X1,sharp),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(4,3,vars(X2,X3,X1)) :- not use(4,3),ttime(X2),vehicleId(X3),vehicleType(X1).
try(4,4,vars(X2,X3,X1)) :- use(4,4),not_holdsAt(abrupt_acceleration(X3,X1,very_abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(4,4,vars(X2,X3,X1)) :- not use(4,4),ttime(X2),vehicleId(X3),vehicleType(X1).
try(4,5,vars(X2,X3,X1)) :- use(4,5),not_holdsAt(abrupt_acceleration(X3,X1,abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(4,5,vars(X2,X3,X1)) :- not use(4,5),ttime(X2),vehicleId(X3),vehicleType(X1).
try(4,6,vars(X2,X3,X1)) :- use(4,6),not_holdsAt(abrupt_deceleration(X3,X1,very_abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(4,6,vars(X2,X3,X1)) :- not use(4,6),ttime(X2),vehicleId(X3),vehicleType(X1).
try(4,7,vars(X2,X3,X1)) :- use(4,7),not_holdsAt(abrupt_deceleration(X3,X1,abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(4,7,vars(X2,X3,X1)) :- not use(4,7),ttime(X2),vehicleId(X3),vehicleType(X1).
initiatedAt(driving_style(X3,X1,unsafe),X2) :- use(5,0),try(5,1,vars(X2,X3,X1)),try(5,2,vars(X2,X3,X1)),try(5,3,vars(X2,X3,X1)),try(5,4,vars(X2,X3,X1)),try(5,5,vars(X2,X3,X1)),try(5,6,vars(X2,X3,X1)),try(5,7,vars(X2,X3,X1)),ttime(X2),vehicleId(X3),vehicleType(X1).
try(5,1,vars(X2,X3,X1)) :- use(5,1),initiatedAt(abrupt_acceleration(X3,X1,very_abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(5,1,vars(X2,X3,X1)) :- not use(5,1),ttime(X2),vehicleId(X3),vehicleType(X1).
try(5,2,vars(X2,X3,X1)) :- use(5,2),holdsAt(sharp_turn(X3,X1,sharp),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(5,2,vars(X2,X3,X1)) :- not use(5,2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(5,3,vars(X2,X3,X1)) :- use(5,3),not_holdsAt(sharp_turn(X3,X1,very_sharp),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(5,3,vars(X2,X3,X1)) :- not use(5,3),ttime(X2),vehicleId(X3),vehicleType(X1).
try(5,4,vars(X2,X3,X1)) :- use(5,4),not_holdsAt(abrupt_acceleration(X3,X1,very_abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(5,4,vars(X2,X3,X1)) :- not use(5,4),ttime(X2),vehicleId(X3),vehicleType(X1).
try(5,5,vars(X2,X3,X1)) :- use(5,5),not_holdsAt(abrupt_acceleration(X3,X1,abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(5,5,vars(X2,X3,X1)) :- not use(5,5),ttime(X2),vehicleId(X3),vehicleType(X1).
try(5,6,vars(X2,X3,X1)) :- use(5,6),not_holdsAt(abrupt_deceleration(X3,X1,very_abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(5,6,vars(X2,X3,X1)) :- not use(5,6),ttime(X2),vehicleId(X3),vehicleType(X1).
try(5,7,vars(X2,X3,X1)) :- use(5,7),not_holdsAt(abrupt_deceleration(X3,X1,abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(5,7,vars(X2,X3,X1)) :- not use(5,7),ttime(X2),vehicleId(X3),vehicleType(X1).
initiatedAt(driving_style(X2,X1,unsafe),X3) :- use(6,0),try(6,1,vars(X2,X3,X1)),try(6,2,vars(X2,X3,X1)),try(6,3,vars(X2,X3,X1)),try(6,4,vars(X2,X3,X1)),try(6,5,vars(X2,X3,X1)),try(6,6,vars(X2,X3,X1)),try(6,7,vars(X2,X3,X1)),vehicleId(X2),ttime(X3),vehicleType(X1).
try(6,1,vars(X2,X3,X1)) :- use(6,1),initiatedAt(sharp_turn(X2,X1,very_sharp),X3),vehicleId(X2),ttime(X3),vehicleType(X1).
try(6,1,vars(X2,X3,X1)) :- not use(6,1),vehicleId(X2),ttime(X3),vehicleType(X1).
try(6,2,vars(X2,X3,X1)) :- use(6,2),not_holdsAt(sharp_turn(X2,X1,very_sharp),X3),vehicleId(X2),ttime(X3),vehicleType(X1).
try(6,2,vars(X2,X3,X1)) :- not use(6,2),vehicleId(X2),ttime(X3),vehicleType(X1).
try(6,3,vars(X2,X3,X1)) :- use(6,3),not_holdsAt(sharp_turn(X2,X1,sharp),X3),vehicleId(X2),ttime(X3),vehicleType(X1).
try(6,3,vars(X2,X3,X1)) :- not use(6,3),vehicleId(X2),ttime(X3),vehicleType(X1).
try(6,4,vars(X2,X3,X1)) :- use(6,4),not_holdsAt(abrupt_acceleration(X2,X1,very_abrupt),X3),vehicleId(X2),ttime(X3),vehicleType(X1).
try(6,4,vars(X2,X3,X1)) :- not use(6,4),vehicleId(X2),ttime(X3),vehicleType(X1).
try(6,5,vars(X2,X3,X1)) :- use(6,5),not_holdsAt(abrupt_acceleration(X2,X1,abrupt),X3),vehicleId(X2),ttime(X3),vehicleType(X1).
try(6,5,vars(X2,X3,X1)) :- not use(6,5),vehicleId(X2),ttime(X3),vehicleType(X1).
try(6,6,vars(X2,X3,X1)) :- use(6,6),not_holdsAt(abrupt_deceleration(X2,X1,very_abrupt),X3),vehicleId(X2),ttime(X3),vehicleType(X1).
try(6,6,vars(X2,X3,X1)) :- not use(6,6),vehicleId(X2),ttime(X3),vehicleType(X1).
try(6,7,vars(X2,X3,X1)) :- use(6,7),not_holdsAt(abrupt_deceleration(X2,X1,abrupt),X3),vehicleId(X2),ttime(X3),vehicleType(X1).
try(6,7,vars(X2,X3,X1)) :- not use(6,7),vehicleId(X2),ttime(X3),vehicleType(X1).
initiatedAt(driving_style(X3,X1,unsafe),X2) :- use(7,0),try(7,1,vars(X2,X3,X1)),try(7,2,vars(X2,X3,X1)),try(7,3,vars(X2,X3,X1)),try(7,4,vars(X2,X3,X1)),try(7,5,vars(X2,X3,X1)),try(7,6,vars(X2,X3,X1)),try(7,7,vars(X2,X3,X1)),ttime(X2),vehicleId(X3),vehicleType(X1).
try(7,1,vars(X2,X3,X1)) :- use(7,1),initiatedAt(sharp_turn(X3,X1,very_sharp),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(7,1,vars(X2,X3,X1)) :- not use(7,1),ttime(X2),vehicleId(X3),vehicleType(X1).
try(7,2,vars(X2,X3,X1)) :- use(7,2),not_holdsAt(sharp_turn(X3,X1,very_sharp),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(7,2,vars(X2,X3,X1)) :- not use(7,2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(7,3,vars(X2,X3,X1)) :- use(7,3),not_holdsAt(sharp_turn(X3,X1,sharp),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(7,3,vars(X2,X3,X1)) :- not use(7,3),ttime(X2),vehicleId(X3),vehicleType(X1).
try(7,4,vars(X2,X3,X1)) :- use(7,4),not_holdsAt(abrupt_acceleration(X3,X1,very_abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(7,4,vars(X2,X3,X1)) :- not use(7,4),ttime(X2),vehicleId(X3),vehicleType(X1).
try(7,5,vars(X2,X3,X1)) :- use(7,5),not_holdsAt(abrupt_acceleration(X3,X1,abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(7,5,vars(X2,X3,X1)) :- not use(7,5),ttime(X2),vehicleId(X3),vehicleType(X1).
try(7,6,vars(X2,X3,X1)) :- use(7,6),not_holdsAt(abrupt_deceleration(X3,X1,very_abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(7,6,vars(X2,X3,X1)) :- not use(7,6),ttime(X2),vehicleId(X3),vehicleType(X1).
try(7,7,vars(X2,X3,X1)) :- use(7,7),not_holdsAt(abrupt_deceleration(X3,X1,abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(7,7,vars(X2,X3,X1)) :- not use(7,7),ttime(X2),vehicleId(X3),vehicleType(X1).
initiatedAt(driving_style(X2,X1,unsafe),X3) :- use(8,0),try(8,1,vars(X2,X3,X1)),try(8,2,vars(X2,X3,X1)),try(8,3,vars(X2,X3,X1)),try(8,4,vars(X2,X3,X1)),try(8,5,vars(X2,X3,X1)),try(8,6,vars(X2,X3,X1)),try(8,7,vars(X2,X3,X1)),try(8,8,vars(X2,X3,X1)),vehicleId(X2),ttime(X3),vehicleType(X1).
try(8,1,vars(X2,X3,X1)) :- use(8,1),initiatedAt(sharp_turn(X2,X1,sharp),X3),vehicleId(X2),ttime(X3),vehicleType(X1).
try(8,1,vars(X2,X3,X1)) :- not use(8,1),vehicleId(X2),ttime(X3),vehicleType(X1).
try(8,2,vars(X2,X3,X1)) :- use(8,2),initiatedAt(abrupt_deceleration(X2,X1,very_abrupt),X3),vehicleId(X2),ttime(X3),vehicleType(X1).
try(8,2,vars(X2,X3,X1)) :- not use(8,2),vehicleId(X2),ttime(X3),vehicleType(X1).
try(8,3,vars(X2,X3,X1)) :- use(8,3),not_holdsAt(sharp_turn(X2,X1,very_sharp),X3),vehicleId(X2),ttime(X3),vehicleType(X1).
try(8,3,vars(X2,X3,X1)) :- not use(8,3),vehicleId(X2),ttime(X3),vehicleType(X1).
try(8,4,vars(X2,X3,X1)) :- use(8,4),not_holdsAt(sharp_turn(X2,X1,sharp),X3),vehicleId(X2),ttime(X3),vehicleType(X1).
try(8,4,vars(X2,X3,X1)) :- not use(8,4),vehicleId(X2),ttime(X3),vehicleType(X1).
try(8,5,vars(X2,X3,X1)) :- use(8,5),not_holdsAt(abrupt_acceleration(X2,X1,very_abrupt),X3),vehicleId(X2),ttime(X3),vehicleType(X1).
try(8,5,vars(X2,X3,X1)) :- not use(8,5),vehicleId(X2),ttime(X3),vehicleType(X1).
try(8,6,vars(X2,X3,X1)) :- use(8,6),not_holdsAt(abrupt_acceleration(X2,X1,abrupt),X3),vehicleId(X2),ttime(X3),vehicleType(X1).
try(8,6,vars(X2,X3,X1)) :- not use(8,6),vehicleId(X2),ttime(X3),vehicleType(X1).
try(8,7,vars(X2,X3,X1)) :- use(8,7),not_holdsAt(abrupt_deceleration(X2,X1,very_abrupt),X3),vehicleId(X2),ttime(X3),vehicleType(X1).
try(8,7,vars(X2,X3,X1)) :- not use(8,7),vehicleId(X2),ttime(X3),vehicleType(X1).
try(8,8,vars(X2,X3,X1)) :- use(8,8),not_holdsAt(abrupt_deceleration(X2,X1,abrupt),X3),vehicleId(X2),ttime(X3),vehicleType(X1).
try(8,8,vars(X2,X3,X1)) :- not use(8,8),vehicleId(X2),ttime(X3),vehicleType(X1).
terminatedAt(driving_style(X3,X1,unsafe),X2) :- use(9,0),try(9,1,vars(X2,X3,X1)),try(9,2,vars(X2,X3,X1)),try(9,3,vars(X2,X3,X1)),try(9,4,vars(X2,X3,X1)),try(9,5,vars(X2,X3,X1)),try(9,6,vars(X2,X3,X1)),try(9,7,vars(X2,X3,X1)),ttime(X2),vehicleId(X3),vehicleType(X1).
try(9,1,vars(X2,X3,X1)) :- use(9,1),holdsAt(abrupt_deceleration(X3,X1,very_abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(9,1,vars(X2,X3,X1)) :- not use(9,1),ttime(X2),vehicleId(X3),vehicleType(X1).
try(9,2,vars(X2,X3,X1)) :- use(9,2),holdsAt(sharp_turn(X3,X1,sharp),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(9,2,vars(X2,X3,X1)) :- not use(9,2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(9,3,vars(X2,X3,X1)) :- use(9,3),terminatedAt(abrupt_deceleration(X3,X1,very_abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(9,3,vars(X2,X3,X1)) :- not use(9,3),ttime(X2),vehicleId(X3),vehicleType(X1).
try(9,4,vars(X2,X3,X1)) :- use(9,4),not_holdsAt(sharp_turn(X3,X1,very_sharp),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(9,4,vars(X2,X3,X1)) :- not use(9,4),ttime(X2),vehicleId(X3),vehicleType(X1).
try(9,5,vars(X2,X3,X1)) :- use(9,5),not_holdsAt(abrupt_acceleration(X3,X1,very_abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(9,5,vars(X2,X3,X1)) :- not use(9,5),ttime(X2),vehicleId(X3),vehicleType(X1).
try(9,6,vars(X2,X3,X1)) :- use(9,6),not_holdsAt(abrupt_acceleration(X3,X1,abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(9,6,vars(X2,X3,X1)) :- not use(9,6),ttime(X2),vehicleId(X3),vehicleType(X1).
try(9,7,vars(X2,X3,X1)) :- use(9,7),not_holdsAt(abrupt_deceleration(X3,X1,abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(9,7,vars(X2,X3,X1)) :- not use(9,7),ttime(X2),vehicleId(X3),vehicleType(X1).
terminatedAt(driving_style(X3,X2,unsafe),X1) :- use(10,0),try(10,1,vars(X2,X3,X1)),try(10,2,vars(X2,X3,X1)),try(10,3,vars(X2,X3,X1)),try(10,4,vars(X2,X3,X1)),try(10,5,vars(X2,X3,X1)),try(10,6,vars(X2,X3,X1)),try(10,7,vars(X2,X3,X1)),try(10,8,vars(X2,X3,X1)),try(10,9,vars(X2,X3,X1)),vehicleType(X2),ttime(X1),vehicleId(X3).
try(10,1,vars(X2,X3,X1)) :- use(10,1),initiatedAt(sharp_turn(X3,X2,sharp),X1),vehicleType(X2),vehicleId(X3),ttime(X1).
try(10,1,vars(X2,X3,X1)) :- not use(10,1),vehicleType(X2),vehicleId(X3),ttime(X1).
try(10,2,vars(X2,X3,X1)) :- use(10,2),terminatedAt(abrupt_acceleration(X3,X2,very_abrupt),X1),vehicleType(X2),vehicleId(X3),ttime(X1).
try(10,2,vars(X2,X3,X1)) :- not use(10,2),vehicleType(X2),vehicleId(X3),ttime(X1).
try(10,3,vars(X2,X3,X1)) :- use(10,3),terminatedAt(abrupt_deceleration(X3,X2,abrupt),X1),vehicleType(X2),vehicleId(X3),ttime(X1).
try(10,3,vars(X2,X3,X1)) :- not use(10,3),vehicleType(X2),vehicleId(X3),ttime(X1).
try(10,4,vars(X2,X3,X1)) :- use(10,4),holdsAt(abrupt_deceleration(X3,X2,abrupt),X1),vehicleType(X2),vehicleId(X3),ttime(X1).
try(10,4,vars(X2,X3,X1)) :- not use(10,4),vehicleType(X2),vehicleId(X3),ttime(X1).
try(10,5,vars(X2,X3,X1)) :- use(10,5),holdsAt(abrupt_acceleration(X3,X2,very_abrupt),X1),vehicleType(X2),vehicleId(X3),ttime(X1).
try(10,5,vars(X2,X3,X1)) :- not use(10,5),vehicleType(X2),vehicleId(X3),ttime(X1).
try(10,6,vars(X2,X3,X1)) :- use(10,6),not_holdsAt(sharp_turn(X3,X2,very_sharp),X1),vehicleType(X2),vehicleId(X3),ttime(X1).
try(10,6,vars(X2,X3,X1)) :- not use(10,6),vehicleType(X2),vehicleId(X3),ttime(X1).
try(10,7,vars(X2,X3,X1)) :- use(10,7),not_holdsAt(sharp_turn(X3,X2,sharp),X1),vehicleType(X2),vehicleId(X3),ttime(X1).
try(10,7,vars(X2,X3,X1)) :- not use(10,7),vehicleType(X2),vehicleId(X3),ttime(X1).
try(10,8,vars(X2,X3,X1)) :- use(10,8),not_holdsAt(abrupt_acceleration(X3,X2,abrupt),X1),vehicleType(X2),vehicleId(X3),ttime(X1).
try(10,8,vars(X2,X3,X1)) :- not use(10,8),vehicleType(X2),vehicleId(X3),ttime(X1).
try(10,9,vars(X2,X3,X1)) :- use(10,9),not_holdsAt(abrupt_deceleration(X3,X2,very_abrupt),X1),vehicleType(X2),vehicleId(X3),ttime(X1).
try(10,9,vars(X2,X3,X1)) :- not use(10,9),vehicleType(X2),vehicleId(X3),ttime(X1).
terminatedAt(driving_style(X3,X1,unsafe),X2) :- use(11,0),try(11,1,vars(X2,X3,X1)),try(11,2,vars(X2,X3,X1)),try(11,3,vars(X2,X3,X1)),try(11,4,vars(X2,X3,X1)),try(11,5,vars(X2,X3,X1)),try(11,6,vars(X2,X3,X1)),try(11,7,vars(X2,X3,X1)),ttime(X2),vehicleId(X3),vehicleType(X1).
try(11,1,vars(X2,X3,X1)) :- use(11,1),holdsAt(abrupt_deceleration(X3,X1,very_abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(11,1,vars(X2,X3,X1)) :- not use(11,1),ttime(X2),vehicleId(X3),vehicleType(X1).
try(11,2,vars(X2,X3,X1)) :- use(11,2),terminatedAt(abrupt_deceleration(X3,X1,very_abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(11,2,vars(X2,X3,X1)) :- not use(11,2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(11,3,vars(X2,X3,X1)) :- use(11,3),not_holdsAt(sharp_turn(X3,X1,very_sharp),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(11,3,vars(X2,X3,X1)) :- not use(11,3),ttime(X2),vehicleId(X3),vehicleType(X1).
try(11,4,vars(X2,X3,X1)) :- use(11,4),not_holdsAt(sharp_turn(X3,X1,sharp),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(11,4,vars(X2,X3,X1)) :- not use(11,4),ttime(X2),vehicleId(X3),vehicleType(X1).
try(11,5,vars(X2,X3,X1)) :- use(11,5),not_holdsAt(abrupt_acceleration(X3,X1,very_abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(11,5,vars(X2,X3,X1)) :- not use(11,5),ttime(X2),vehicleId(X3),vehicleType(X1).
try(11,6,vars(X2,X3,X1)) :- use(11,6),not_holdsAt(abrupt_acceleration(X3,X1,abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(11,6,vars(X2,X3,X1)) :- not use(11,6),ttime(X2),vehicleId(X3),vehicleType(X1).
try(11,7,vars(X2,X3,X1)) :- use(11,7),not_holdsAt(abrupt_deceleration(X3,X1,abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(11,7,vars(X2,X3,X1)) :- not use(11,7),ttime(X2),vehicleId(X3),vehicleType(X1).
terminatedAt(driving_style(X3,X2,unsafe),X1) :- use(12,0),try(12,1,vars(X2,X3,X1)),try(12,2,vars(X2,X3,X1)),try(12,3,vars(X2,X3,X1)),try(12,4,vars(X2,X3,X1)),try(12,5,vars(X2,X3,X1)),try(12,6,vars(X2,X3,X1)),try(12,7,vars(X2,X3,X1)),vehicleType(X2),ttime(X1),vehicleId(X3).
try(12,1,vars(X2,X3,X1)) :- use(12,1),holdsAt(sharp_turn(X3,X2,sharp),X1),vehicleType(X2),vehicleId(X3),ttime(X1).
try(12,1,vars(X2,X3,X1)) :- not use(12,1),vehicleType(X2),vehicleId(X3),ttime(X1).
try(12,2,vars(X2,X3,X1)) :- use(12,2),terminatedAt(abrupt_acceleration(X3,X2,very_abrupt),X1),vehicleType(X2),vehicleId(X3),ttime(X1).
try(12,2,vars(X2,X3,X1)) :- not use(12,2),vehicleType(X2),vehicleId(X3),ttime(X1).
try(12,3,vars(X2,X3,X1)) :- use(12,3),holdsAt(abrupt_acceleration(X3,X2,very_abrupt),X1),vehicleType(X2),vehicleId(X3),ttime(X1).
try(12,3,vars(X2,X3,X1)) :- not use(12,3),vehicleType(X2),vehicleId(X3),ttime(X1).
try(12,4,vars(X2,X3,X1)) :- use(12,4),not_holdsAt(sharp_turn(X3,X2,very_sharp),X1),vehicleType(X2),vehicleId(X3),ttime(X1).
try(12,4,vars(X2,X3,X1)) :- not use(12,4),vehicleType(X2),vehicleId(X3),ttime(X1).
try(12,5,vars(X2,X3,X1)) :- use(12,5),not_holdsAt(abrupt_acceleration(X3,X2,abrupt),X1),vehicleType(X2),vehicleId(X3),ttime(X1).
try(12,5,vars(X2,X3,X1)) :- not use(12,5),vehicleType(X2),vehicleId(X3),ttime(X1).
try(12,6,vars(X2,X3,X1)) :- use(12,6),not_holdsAt(abrupt_deceleration(X3,X2,very_abrupt),X1),vehicleType(X2),vehicleId(X3),ttime(X1).
try(12,6,vars(X2,X3,X1)) :- not use(12,6),vehicleType(X2),vehicleId(X3),ttime(X1).
try(12,7,vars(X2,X3,X1)) :- use(12,7),not_holdsAt(abrupt_deceleration(X3,X2,abrupt),X1),vehicleType(X2),vehicleId(X3),ttime(X1).
try(12,7,vars(X2,X3,X1)) :- not use(12,7),vehicleType(X2),vehicleId(X3),ttime(X1).
terminatedAt(driving_style(X3,X1,unsafe),X2) :- use(13,0),try(13,1,vars(X2,X3,X1)),try(13,2,vars(X2,X3,X1)),try(13,3,vars(X2,X3,X1)),try(13,4,vars(X2,X3,X1)),try(13,5,vars(X2,X3,X1)),try(13,6,vars(X2,X3,X1)),try(13,7,vars(X2,X3,X1)),try(13,8,vars(X2,X3,X1)),ttime(X2),vehicleId(X3),vehicleType(X1).
try(13,1,vars(X2,X3,X1)) :- use(13,1),terminatedAt(sharp_turn(X3,X1,sharp),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(13,1,vars(X2,X3,X1)) :- not use(13,1),ttime(X2),vehicleId(X3),vehicleType(X1).
try(13,2,vars(X2,X3,X1)) :- use(13,2),terminatedAt(abrupt_deceleration(X3,X1,very_abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(13,2,vars(X2,X3,X1)) :- not use(13,2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(13,3,vars(X2,X3,X1)) :- use(13,3),holdsAt(sharp_turn(X3,X1,sharp),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(13,3,vars(X2,X3,X1)) :- not use(13,3),ttime(X2),vehicleId(X3),vehicleType(X1).
try(13,4,vars(X2,X3,X1)) :- use(13,4),holdsAt(abrupt_deceleration(X3,X1,very_abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(13,4,vars(X2,X3,X1)) :- not use(13,4),ttime(X2),vehicleId(X3),vehicleType(X1).
try(13,5,vars(X2,X3,X1)) :- use(13,5),not_holdsAt(sharp_turn(X3,X1,very_sharp),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(13,5,vars(X2,X3,X1)) :- not use(13,5),ttime(X2),vehicleId(X3),vehicleType(X1).
try(13,6,vars(X2,X3,X1)) :- use(13,6),not_holdsAt(abrupt_acceleration(X3,X1,very_abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(13,6,vars(X2,X3,X1)) :- not use(13,6),ttime(X2),vehicleId(X3),vehicleType(X1).
try(13,7,vars(X2,X3,X1)) :- use(13,7),not_holdsAt(abrupt_acceleration(X3,X1,abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(13,7,vars(X2,X3,X1)) :- not use(13,7),ttime(X2),vehicleId(X3),vehicleType(X1).
try(13,8,vars(X2,X3,X1)) :- use(13,8),not_holdsAt(abrupt_deceleration(X3,X1,abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(13,8,vars(X2,X3,X1)) :- not use(13,8),ttime(X2),vehicleId(X3),vehicleType(X1).
terminatedAt(driving_style(X3,X1,unsafe),X2) :- use(14,0),try(14,1,vars(X2,X3,X1)),try(14,2,vars(X2,X3,X1)),try(14,3,vars(X2,X3,X1)),try(14,4,vars(X2,X3,X1)),try(14,5,vars(X2,X3,X1)),try(14,6,vars(X2,X3,X1)),try(14,7,vars(X2,X3,X1)),try(14,8,vars(X2,X3,X1)),ttime(X2),vehicleId(X3),vehicleType(X1).
try(14,1,vars(X2,X3,X1)) :- use(14,1),holdsAt(abrupt_acceleration(X3,X1,very_abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(14,1,vars(X2,X3,X1)) :- not use(14,1),ttime(X2),vehicleId(X3),vehicleType(X1).
try(14,2,vars(X2,X3,X1)) :- use(14,2),terminatedAt(sharp_turn(X3,X1,sharp),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(14,2,vars(X2,X3,X1)) :- not use(14,2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(14,3,vars(X2,X3,X1)) :- use(14,3),terminatedAt(abrupt_acceleration(X3,X1,very_abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(14,3,vars(X2,X3,X1)) :- not use(14,3),ttime(X2),vehicleId(X3),vehicleType(X1).
try(14,4,vars(X2,X3,X1)) :- use(14,4),holdsAt(sharp_turn(X3,X1,sharp),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(14,4,vars(X2,X3,X1)) :- not use(14,4),ttime(X2),vehicleId(X3),vehicleType(X1).
try(14,5,vars(X2,X3,X1)) :- use(14,5),not_holdsAt(sharp_turn(X3,X1,very_sharp),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(14,5,vars(X2,X3,X1)) :- not use(14,5),ttime(X2),vehicleId(X3),vehicleType(X1).
try(14,6,vars(X2,X3,X1)) :- use(14,6),not_holdsAt(abrupt_acceleration(X3,X1,abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(14,6,vars(X2,X3,X1)) :- not use(14,6),ttime(X2),vehicleId(X3),vehicleType(X1).
try(14,7,vars(X2,X3,X1)) :- use(14,7),not_holdsAt(abrupt_deceleration(X3,X1,very_abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(14,7,vars(X2,X3,X1)) :- not use(14,7),ttime(X2),vehicleId(X3),vehicleType(X1).
try(14,8,vars(X2,X3,X1)) :- use(14,8),not_holdsAt(abrupt_deceleration(X3,X1,abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(14,8,vars(X2,X3,X1)) :- not use(14,8),ttime(X2),vehicleId(X3),vehicleType(X1).
terminatedAt(driving_style(X3,X1,unsafe),X2) :- use(15,0),try(15,1,vars(X2,X3,X1)),try(15,2,vars(X2,X3,X1)),try(15,3,vars(X2,X3,X1)),try(15,4,vars(X2,X3,X1)),try(15,5,vars(X2,X3,X1)),try(15,6,vars(X2,X3,X1)),try(15,7,vars(X2,X3,X1)),ttime(X2),vehicleId(X3),vehicleType(X1).
try(15,1,vars(X2,X3,X1)) :- use(15,1),holdsAt(abrupt_deceleration(X3,X1,very_abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(15,1,vars(X2,X3,X1)) :- not use(15,1),ttime(X2),vehicleId(X3),vehicleType(X1).
try(15,2,vars(X2,X3,X1)) :- use(15,2),terminatedAt(abrupt_deceleration(X3,X1,very_abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(15,2,vars(X2,X3,X1)) :- not use(15,2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(15,3,vars(X2,X3,X1)) :- use(15,3),holdsAt(abrupt_acceleration(X3,X1,abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(15,3,vars(X2,X3,X1)) :- not use(15,3),ttime(X2),vehicleId(X3),vehicleType(X1).
try(15,4,vars(X2,X3,X1)) :- use(15,4),not_holdsAt(sharp_turn(X3,X1,very_sharp),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(15,4,vars(X2,X3,X1)) :- not use(15,4),ttime(X2),vehicleId(X3),vehicleType(X1).
try(15,5,vars(X2,X3,X1)) :- use(15,5),not_holdsAt(sharp_turn(X3,X1,sharp),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(15,5,vars(X2,X3,X1)) :- not use(15,5),ttime(X2),vehicleId(X3),vehicleType(X1).
try(15,6,vars(X2,X3,X1)) :- use(15,6),not_holdsAt(abrupt_acceleration(X3,X1,very_abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(15,6,vars(X2,X3,X1)) :- not use(15,6),ttime(X2),vehicleId(X3),vehicleType(X1).
try(15,7,vars(X2,X3,X1)) :- use(15,7),not_holdsAt(abrupt_deceleration(X3,X1,abrupt),X2),ttime(X2),vehicleId(X3),vehicleType(X1).
try(15,7,vars(X2,X3,X1)) :- not use(15,7),ttime(X2),vehicleId(X3),vehicleType(X1).



clauseIndex(1..15).

literalIndex(0..10).

{use(1,1..8)}.{use(2,1..7)}.{use(3,1..7)}.{use(4,1..7)}.{use(5,1..7)}.{use(6,1..7)}.{use(7,1..7)}.{use(8,1..8)}.{use(9,1..7)}.{use(10,1..9)}.{use(11,1..7)}.{use(12,1..7)}.{use(13,1..8)}.{use(14,1..8)}.{use(15,1..7)}.



{use(I,J)}:-clauseIndex(I),literalIndex(J).

{use(I,J,K)}:-clauseIndex(I),clauseIndex(J),literalIndex(K).

#minimize{use(I,J),use(I,J,K)}.

:- use(I,J), not use(I,0).

#hide.

#show use/2.

#show use/3.