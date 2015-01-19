initiatedAt(punctuality(id75,bus,punctual),1011) :- 
        initiatedAt(punctuality(id75,bus,punctual),1011),
        terminatedAt(punctuality(id75,bus,non_punctual),1011),
        happensAt(my_stop_enter(id75,bus,stopId,early),1011),
        not_happensAt(my_stop_enter(id75,bus,stopId,scheduled),1011),
        not_happensAt(my_stop_enter(id75,bus,stopId,late),1011),
        not_happensAt(my_stop_leave(id75,bus,stopId,scheduled),1011),
        not_happensAt(my_stop_leave(id75,bus,stopId,early),1011),
        not_happensAt(my_stop_leave(id75,bus,stopId,late),1011).

initiatedAt(punctuality(id75,bus,non_punctual),1004) :- 
        initiatedAt(punctuality(id75,bus,non_punctual),1004),
        terminatedAt(punctuality(id75,bus,punctual),1004),
        happensAt(my_stop_enter(id75,bus,stopId,late),1004),
        not_happensAt(my_stop_enter(id75,bus,stopId,scheduled),1004),
        not_happensAt(my_stop_enter(id75,bus,stopId,early),1004),
        not_happensAt(my_stop_leave(id75,bus,stopId,scheduled),1004),
        not_happensAt(my_stop_leave(id75,bus,stopId,early),1004),
        not_happensAt(my_stop_leave(id75,bus,stopId,late),1004).

terminatedAt(punctuality(id75,bus,non_punctual),1011) :- 
        initiatedAt(punctuality(id75,bus,punctual),1011),
        terminatedAt(punctuality(id75,bus,non_punctual),1011),
        happensAt(my_stop_enter(id75,bus,stopId,early),1011),
        not_happensAt(my_stop_enter(id75,bus,stopId,scheduled),1011),
        not_happensAt(my_stop_enter(id75,bus,stopId,late),1011),
        not_happensAt(my_stop_leave(id75,bus,stopId,scheduled),1011),
        not_happensAt(my_stop_leave(id75,bus,stopId,early),1011),
        not_happensAt(my_stop_leave(id75,bus,stopId,late),1011).

terminatedAt(punctuality(id75,bus,punctual),1004) :- 
        initiatedAt(punctuality(id75,bus,non_punctual),1004),
        terminatedAt(punctuality(id75,bus,punctual),1004),
        happensAt(my_stop_enter(id75,bus,stopId,late),1004),
        not_happensAt(my_stop_enter(id75,bus,stopId,scheduled),1004),
        not_happensAt(my_stop_enter(id75,bus,stopId,early),1004),
        not_happensAt(my_stop_leave(id75,bus,stopId,scheduled),1004),
        not_happensAt(my_stop_leave(id75,bus,stopId,early),1004),
        not_happensAt(my_stop_leave(id75,bus,stopId,late),1004).