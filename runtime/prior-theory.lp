terminatedAt(driving_style(X3,X1,unsafe),X2) :- 
        terminatedAt(abrupt_acceleration(X3,X1,very_abrupt),X2),
        not_holdsAt(abrupt_deceleration(X3,X1,very_abrupt),X2),
        ttime(X2),
        vehicleId(X3),
        vehicleType(X1).

terminatedAt(driving_style(X3,X1,unsafe),X2) :- 
        terminatedAt(abrupt_deceleration(X3,X1,very_abrupt),X2),
        not_holdsAt(abrupt_acceleration(X3,X1,very_abrupt),X2),
        ttime(X2),
        vehicleId(X3),
        vehicleType(X1).

initiatedAt(driving_style(X3,X1,unsafe),X2) :- 
        initiatedAt(sharp_turn(X3,X1,very_sharp),X2),
        ttime(X2),
        vehicleId(X3),
        vehicleType(X1).

initiatedAt(driving_style(X3,X1,unsafe),X2) :- 
        initiatedAt(abrupt_deceleration(X3,X1,very_abrupt),X2),
        ttime(X2),
        vehicleId(X3),
        vehicleType(X1).

initiatedAt(driving_style(X3,X1,unsafe),X2) :- 
        initiatedAt(abrupt_acceleration(X3,X1,very_abrupt),X2),
        ttime(X2),
        vehicleId(X3),
        vehicleType(X1).



