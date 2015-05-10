initiatedAt(driving_style(id75,bus,unsafe),308) :- 
        initiatedAt(abrupt_acceleration(id75,bus,very_abrupt),308),
        holdsAt(sharp_turn(id75,bus,sharp),308),
        not_holdsAt(sharp_turn(id75,bus,very_sharp),308),
        not_holdsAt(abrupt_acceleration(id75,bus,very_abrupt),308),
        not_holdsAt(abrupt_acceleration(id75,bus,abrupt),308),
        not_holdsAt(abrupt_deceleration(id75,bus,very_abrupt),308),
        not_holdsAt(abrupt_deceleration(id75,bus,abrupt),308).

initiatedAt(driving_style(id75,bus,unsafe),322) :- 
        initiatedAt(sharp_turn(id75,bus,very_sharp),322),
        initiatedAt(abrupt_acceleration(id75,bus,abrupt),322),
        not_holdsAt(sharp_turn(id75,bus,very_sharp),322),
        not_holdsAt(sharp_turn(id75,bus,sharp),322),
        not_holdsAt(abrupt_acceleration(id75,bus,very_abrupt),322),
        not_holdsAt(abrupt_acceleration(id75,bus,abrupt),322),
        not_holdsAt(abrupt_deceleration(id75,bus,very_abrupt),322),
        not_holdsAt(abrupt_deceleration(id75,bus,abrupt),322).

initiatedAt(driving_style(id75,bus,unsafe),330) :- 
        initiatedAt(sharp_turn(id75,bus,very_sharp),330),
        initiatedAt(abrupt_acceleration(id75,bus,very_abrupt),330),
        not_holdsAt(sharp_turn(id75,bus,very_sharp),330),
        not_holdsAt(sharp_turn(id75,bus,sharp),330),
        not_holdsAt(abrupt_acceleration(id75,bus,very_abrupt),330),
        not_holdsAt(abrupt_acceleration(id75,bus,abrupt),330),
        not_holdsAt(abrupt_deceleration(id75,bus,very_abrupt),330),
        not_holdsAt(abrupt_deceleration(id75,bus,abrupt),330).

initiatedAt(driving_style(id75,bus,unsafe),342) :- 
        initiatedAt(abrupt_acceleration(id75,bus,very_abrupt),342),
        initiatedAt(abrupt_deceleration(id75,bus,very_abrupt),342),
        not_holdsAt(sharp_turn(id75,bus,very_sharp),342),
        not_holdsAt(sharp_turn(id75,bus,sharp),342),
        not_holdsAt(abrupt_acceleration(id75,bus,very_abrupt),342),
        not_holdsAt(abrupt_acceleration(id75,bus,abrupt),342),
        not_holdsAt(abrupt_deceleration(id75,bus,very_abrupt),342),
        not_holdsAt(abrupt_deceleration(id75,bus,abrupt),342).

initiatedAt(driving_style(id75,bus,unsafe),314) :- 
        initiatedAt(abrupt_deceleration(id75,bus,very_abrupt),314),
        not_holdsAt(sharp_turn(id75,bus,very_sharp),314),
        not_holdsAt(sharp_turn(id75,bus,sharp),314),
        not_holdsAt(abrupt_acceleration(id75,bus,very_abrupt),314),
        not_holdsAt(abrupt_acceleration(id75,bus,abrupt),314),
        not_holdsAt(abrupt_deceleration(id75,bus,very_abrupt),314),
        not_holdsAt(abrupt_deceleration(id75,bus,abrupt),314).

initiatedAt(driving_style(id75,bus,unsafe),300) :- 
        initiatedAt(abrupt_acceleration(id75,bus,very_abrupt),300),
        holdsAt(abrupt_deceleration(id75,bus,abrupt),300),
        not_holdsAt(sharp_turn(id75,bus,very_sharp),300),
        not_holdsAt(sharp_turn(id75,bus,sharp),300),
        not_holdsAt(abrupt_acceleration(id75,bus,very_abrupt),300),
        not_holdsAt(abrupt_acceleration(id75,bus,abrupt),300),
        not_holdsAt(abrupt_deceleration(id75,bus,very_abrupt),300).

terminatedAt(driving_style(id75,bus,unsafe),303) :- 
        holdsAt(sharp_turn(id75,bus,sharp),303),
        terminatedAt(sharp_turn(id75,bus,sharp),303),
        terminatedAt(abrupt_acceleration(id75,bus,very_abrupt),303),
        holdsAt(abrupt_acceleration(id75,bus,very_abrupt),303),
        holdsAt(abrupt_deceleration(id75,bus,abrupt),303),
        not_holdsAt(sharp_turn(id75,bus,very_sharp),303),
        not_holdsAt(abrupt_acceleration(id75,bus,abrupt),303),
        not_holdsAt(abrupt_deceleration(id75,bus,very_abrupt),303).

terminatedAt(driving_style(id75,bus,unsafe),319) :- 
        terminatedAt(sharp_turn(id75,bus,sharp),319),
        terminatedAt(abrupt_acceleration(id75,bus,very_abrupt),319),
        holdsAt(sharp_turn(id75,bus,sharp),319),
        holdsAt(abrupt_acceleration(id75,bus,very_abrupt),319),
        not_holdsAt(sharp_turn(id75,bus,very_sharp),319),
        not_holdsAt(abrupt_acceleration(id75,bus,abrupt),319),
        not_holdsAt(abrupt_deceleration(id75,bus,very_abrupt),319),
        not_holdsAt(abrupt_deceleration(id75,bus,abrupt),319).

terminatedAt(driving_style(id75,bus,unsafe),327) :- 
        holdsAt(abrupt_deceleration(id75,bus,abrupt),327),
        terminatedAt(sharp_turn(id75,bus,very_sharp),327),
        terminatedAt(abrupt_acceleration(id75,bus,abrupt),327),
        holdsAt(abrupt_acceleration(id75,bus,abrupt),327),
        holdsAt(sharp_turn(id75,bus,very_sharp),327),
        not_holdsAt(sharp_turn(id75,bus,sharp),327),
        not_holdsAt(abrupt_acceleration(id75,bus,very_abrupt),327),
        not_holdsAt(abrupt_deceleration(id75,bus,very_abrupt),327).

terminatedAt(driving_style(id75,bus,unsafe),344) :- 
        holdsAt(sharp_turn(id75,bus,sharp),344),
        terminatedAt(sharp_turn(id75,bus,sharp),344),
        terminatedAt(abrupt_acceleration(id75,bus,very_abrupt),344),
        holdsAt(abrupt_acceleration(id75,bus,very_abrupt),344),
        not_holdsAt(sharp_turn(id75,bus,very_sharp),344),
        not_holdsAt(abrupt_acceleration(id75,bus,abrupt),344),
        not_holdsAt(abrupt_deceleration(id75,bus,very_abrupt),344),
        not_holdsAt(abrupt_deceleration(id75,bus,abrupt),344).

terminatedAt(driving_style(id75,bus,unsafe),336) :- 
        terminatedAt(abrupt_acceleration(id75,bus,very_abrupt),336),
        holdsAt(abrupt_acceleration(id75,bus,very_abrupt),336),
        not_holdsAt(sharp_turn(id75,bus,very_sharp),336),
        not_holdsAt(sharp_turn(id75,bus,sharp),336),
        not_holdsAt(abrupt_acceleration(id75,bus,abrupt),336),
        not_holdsAt(abrupt_deceleration(id75,bus,very_abrupt),336),
        not_holdsAt(abrupt_deceleration(id75,bus,abrupt),336).

terminatedAt(driving_style(id75,bus,unsafe),312) :- 
        terminatedAt(abrupt_acceleration(id75,bus,very_abrupt),312),
        holdsAt(abrupt_acceleration(id75,bus,very_abrupt),312),
        not_holdsAt(sharp_turn(id75,bus,very_sharp),312),
        not_holdsAt(sharp_turn(id75,bus,sharp),312),
        not_holdsAt(abrupt_acceleration(id75,bus,abrupt),312),
        not_holdsAt(abrupt_deceleration(id75,bus,very_abrupt),312),
        not_holdsAt(abrupt_deceleration(id75,bus,abrupt),312).