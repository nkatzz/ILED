

terminatedAt(driving_style(X3,X1,unsafe),X2) :- 
        terminatedAt(sharp_turn(X3,X1,sharp),X2),
        terminatedAt(abrupt_acceleration(X3,X1,very_abrupt),X2),
        ttime(X2),
        vehicleId(X3),
        vehicleType(X1).

initiatedAt(driving_style(X3,X1,unsafe),X2) :- 
        initiatedAt(abrupt_deceleration(X3,X1,very_abrupt),X2),
        ttime(X2),
        vehicleId(X3),
        vehicleType(X1).

terminatedAt(driving_style(X3,X1,unsafe),X2) :- 
        terminatedAt(sharp_turn(X3,X1,very_sharp),X2),
        not_holdsAt(abrupt_acceleration(X3,X1,very_abrupt),X2),
        not_holdsAt(abrupt_deceleration(X3,X1,very_abrupt),X2),
        ttime(X2),
        vehicleId(X3),
        vehicleType(X1).

terminatedAt(driving_style(X3,X1,unsafe),X2) :- 
        terminatedAt(sharp_turn(X3,X1,very_sharp),X2),
        holdsAt(abrupt_acceleration(X3,X1,abrupt),X2),
        ttime(X2),
        vehicleId(X3),
        vehicleType(X1).

initiatedAt(driving_style(X2,X1,unsafe),X3) :- 
        initiatedAt(abrupt_acceleration(X2,X1,very_abrupt),X3),
        vehicleId(X2),
        ttime(X3),
        vehicleType(X1).

initiatedAt(driving_style(X3,X1,unsafe),X2) :- 
        initiatedAt(sharp_turn(X3,X1,very_sharp),X2),
        ttime(X2),
        vehicleId(X3),
        vehicleType(X1).

terminatedAt(driving_style(X2,X1,unsafe),X3) :- 
        terminatedAt(abrupt_deceleration(X2,X1,very_abrupt),X3),
        not_holdsAt(abrupt_acceleration(X2,X1,very_abrupt),X3),
        not_holdsAt(sharp_turn(X2,X1,very_sharp),X3),
        vehicleId(X2),
        ttime(X3),
        vehicleType(X1).

terminatedAt(driving_style(X3,X1,unsafe),X2) :- 
        terminatedAt(abrupt_acceleration(X3,X1,very_abrupt),X2),
        not_holdsAt(abrupt_deceleration(X3,X1,very_abrupt),X2),
        not_holdsAt(sharp_turn(X3,X1,very_sharp),X2),
        ttime(X2),
        vehicleId(X3),
        vehicleType(X1).