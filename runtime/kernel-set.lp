initiatedAt(driving_style(id75,bus,unsafe),354) :- 
        initiatedAt(abrupt_acceleration(id75,bus,very_abrupt),354),
        initiatedAt(abrupt_deceleration(id75,bus,abrupt),354),
        not_holdsAt(sharp_turn(id75,bus,very_sharp),354),
        not_holdsAt(sharp_turn(id75,bus,sharp),354),
        not_holdsAt(abrupt_acceleration(id75,bus,very_abrupt),354),
        not_holdsAt(abrupt_acceleration(id75,bus,abrupt),354),
        not_holdsAt(abrupt_deceleration(id75,bus,very_abrupt),354),
        not_holdsAt(abrupt_deceleration(id75,bus,abrupt),354).

initiatedAt(driving_style(id75,bus,unsafe),362) :- 
        initiatedAt(abrupt_deceleration(id75,bus,very_abrupt),362),
        not_holdsAt(sharp_turn(id75,bus,very_sharp),362),
        not_holdsAt(sharp_turn(id75,bus,sharp),362),
        not_holdsAt(abrupt_acceleration(id75,bus,very_abrupt),362),
        not_holdsAt(abrupt_acceleration(id75,bus,abrupt),362),
        not_holdsAt(abrupt_deceleration(id75,bus,very_abrupt),362),
        not_holdsAt(abrupt_deceleration(id75,bus,abrupt),362).

initiatedAt(driving_style(id75,bus,unsafe),364) :- 
        initiatedAt(abrupt_acceleration(id75,bus,very_abrupt),364),
        not_holdsAt(sharp_turn(id75,bus,very_sharp),364),
        not_holdsAt(sharp_turn(id75,bus,sharp),364),
        not_holdsAt(abrupt_acceleration(id75,bus,very_abrupt),364),
        not_holdsAt(abrupt_acceleration(id75,bus,abrupt),364),
        not_holdsAt(abrupt_deceleration(id75,bus,very_abrupt),364),
        not_holdsAt(abrupt_deceleration(id75,bus,abrupt),364).

initiatedAt(driving_style(id75,bus,unsafe),370) :- 
        initiatedAt(abrupt_deceleration(id75,bus,very_abrupt),370),
        not_holdsAt(sharp_turn(id75,bus,very_sharp),370),
        not_holdsAt(sharp_turn(id75,bus,sharp),370),
        not_holdsAt(abrupt_acceleration(id75,bus,very_abrupt),370),
        not_holdsAt(abrupt_acceleration(id75,bus,abrupt),370),
        not_holdsAt(abrupt_deceleration(id75,bus,very_abrupt),370),
        not_holdsAt(abrupt_deceleration(id75,bus,abrupt),370).

initiatedAt(driving_style(id75,bus,unsafe),383) :- 
        initiatedAt(abrupt_acceleration(id75,bus,very_abrupt),383),
        holdsAt(sharp_turn(id75,bus,sharp),383),
        not_holdsAt(sharp_turn(id75,bus,very_sharp),383),
        not_holdsAt(abrupt_acceleration(id75,bus,very_abrupt),383),
        not_holdsAt(abrupt_acceleration(id75,bus,abrupt),383),
        not_holdsAt(abrupt_deceleration(id75,bus,very_abrupt),383),
        not_holdsAt(abrupt_deceleration(id75,bus,abrupt),383).

initiatedAt(driving_style(id75,bus,unsafe),394) :- 
        initiatedAt(sharp_turn(id75,bus,very_sharp),394),
        not_holdsAt(sharp_turn(id75,bus,very_sharp),394),
        not_holdsAt(sharp_turn(id75,bus,sharp),394),
        not_holdsAt(abrupt_acceleration(id75,bus,very_abrupt),394),
        not_holdsAt(abrupt_acceleration(id75,bus,abrupt),394),
        not_holdsAt(abrupt_deceleration(id75,bus,very_abrupt),394),
        not_holdsAt(abrupt_deceleration(id75,bus,abrupt),394).

initiatedAt(driving_style(id75,bus,unsafe),386) :- 
        initiatedAt(sharp_turn(id75,bus,very_sharp),386),
        not_holdsAt(sharp_turn(id75,bus,very_sharp),386),
        not_holdsAt(sharp_turn(id75,bus,sharp),386),
        not_holdsAt(abrupt_acceleration(id75,bus,very_abrupt),386),
        not_holdsAt(abrupt_acceleration(id75,bus,abrupt),386),
        not_holdsAt(abrupt_deceleration(id75,bus,very_abrupt),386),
        not_holdsAt(abrupt_deceleration(id75,bus,abrupt),386).

initiatedAt(driving_style(id75,bus,unsafe),350) :- 
        initiatedAt(sharp_turn(id75,bus,sharp),350),
        initiatedAt(abrupt_deceleration(id75,bus,very_abrupt),350),
        not_holdsAt(sharp_turn(id75,bus,very_sharp),350),
        not_holdsAt(sharp_turn(id75,bus,sharp),350),
        not_holdsAt(abrupt_acceleration(id75,bus,very_abrupt),350),
        not_holdsAt(abrupt_acceleration(id75,bus,abrupt),350),
        not_holdsAt(abrupt_deceleration(id75,bus,very_abrupt),350),
        not_holdsAt(abrupt_deceleration(id75,bus,abrupt),350).

terminatedAt(driving_style(id75,bus,unsafe),351) :- 
        holdsAt(abrupt_deceleration(id75,bus,very_abrupt),351),
        holdsAt(sharp_turn(id75,bus,sharp),351),
        terminatedAt(abrupt_deceleration(id75,bus,very_abrupt),351),
        not_holdsAt(sharp_turn(id75,bus,very_sharp),351),
        not_holdsAt(abrupt_acceleration(id75,bus,very_abrupt),351),
        not_holdsAt(abrupt_acceleration(id75,bus,abrupt),351),
        not_holdsAt(abrupt_deceleration(id75,bus,abrupt),351).

terminatedAt(driving_style(id75,bus,unsafe),357) :- 
        initiatedAt(sharp_turn(id75,bus,sharp),357),
        terminatedAt(abrupt_acceleration(id75,bus,very_abrupt),357),
        terminatedAt(abrupt_deceleration(id75,bus,abrupt),357),
        holdsAt(abrupt_deceleration(id75,bus,abrupt),357),
        holdsAt(abrupt_acceleration(id75,bus,very_abrupt),357),
        not_holdsAt(sharp_turn(id75,bus,very_sharp),357),
        not_holdsAt(sharp_turn(id75,bus,sharp),357),
        not_holdsAt(abrupt_acceleration(id75,bus,abrupt),357),
        not_holdsAt(abrupt_deceleration(id75,bus,very_abrupt),357).

terminatedAt(driving_style(id75,bus,unsafe),363) :- 
        holdsAt(abrupt_deceleration(id75,bus,very_abrupt),363),
        terminatedAt(abrupt_deceleration(id75,bus,very_abrupt),363),
        not_holdsAt(sharp_turn(id75,bus,very_sharp),363),
        not_holdsAt(sharp_turn(id75,bus,sharp),363),
        not_holdsAt(abrupt_acceleration(id75,bus,very_abrupt),363),
        not_holdsAt(abrupt_acceleration(id75,bus,abrupt),363),
        not_holdsAt(abrupt_deceleration(id75,bus,abrupt),363).

terminatedAt(driving_style(id75,bus,unsafe),366) :- 
        holdsAt(sharp_turn(id75,bus,sharp),366),
        terminatedAt(abrupt_acceleration(id75,bus,very_abrupt),366),
        holdsAt(abrupt_acceleration(id75,bus,very_abrupt),366),
        not_holdsAt(sharp_turn(id75,bus,very_sharp),366),
        not_holdsAt(abrupt_acceleration(id75,bus,abrupt),366),
        not_holdsAt(abrupt_deceleration(id75,bus,very_abrupt),366),
        not_holdsAt(abrupt_deceleration(id75,bus,abrupt),366).

terminatedAt(driving_style(id75,bus,unsafe),374) :- 
        terminatedAt(sharp_turn(id75,bus,sharp),374),
        terminatedAt(abrupt_deceleration(id75,bus,very_abrupt),374),
        holdsAt(sharp_turn(id75,bus,sharp),374),
        holdsAt(abrupt_deceleration(id75,bus,very_abrupt),374),
        not_holdsAt(sharp_turn(id75,bus,very_sharp),374),
        not_holdsAt(abrupt_acceleration(id75,bus,very_abrupt),374),
        not_holdsAt(abrupt_acceleration(id75,bus,abrupt),374),
        not_holdsAt(abrupt_deceleration(id75,bus,abrupt),374).

terminatedAt(driving_style(id75,bus,unsafe),384) :- 
        holdsAt(abrupt_acceleration(id75,bus,very_abrupt),384),
        terminatedAt(sharp_turn(id75,bus,sharp),384),
        terminatedAt(abrupt_acceleration(id75,bus,very_abrupt),384),
        holdsAt(sharp_turn(id75,bus,sharp),384),
        not_holdsAt(sharp_turn(id75,bus,very_sharp),384),
        not_holdsAt(abrupt_acceleration(id75,bus,abrupt),384),
        not_holdsAt(abrupt_deceleration(id75,bus,very_abrupt),384),
        not_holdsAt(abrupt_deceleration(id75,bus,abrupt),384).

terminatedAt(driving_style(id75,bus,unsafe),390) :- 
        holdsAt(abrupt_deceleration(id75,bus,very_abrupt),390),
        terminatedAt(abrupt_deceleration(id75,bus,very_abrupt),390),
        holdsAt(abrupt_acceleration(id75,bus,abrupt),390),
        not_holdsAt(sharp_turn(id75,bus,very_sharp),390),
        not_holdsAt(sharp_turn(id75,bus,sharp),390),
        not_holdsAt(abrupt_acceleration(id75,bus,very_abrupt),390),
        not_holdsAt(abrupt_deceleration(id75,bus,abrupt),390).