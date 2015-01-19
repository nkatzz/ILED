initiatedAt(punctuality(id75,bus,punctual),1011).
initiatedAt(punctuality(id75,bus,non_punctual),1004).
terminatedAt(punctuality(id75,bus,non_punctual),1011).
terminatedAt(punctuality(id75,bus,punctual),1004).
#hide.
#show happensAt(my_stop_enter(id75,bus,X0,X1),1004).
#show happensAt(my_stop_leave(id75,bus,X0,X1),1004).
#show not_happensAt(my_stop_enter(id75,bus,X0,X1),1004).
#show not_happensAt(my_stop_leave(id75,bus,X0,X1),1004).
#show initiatedAt(punctuality(id75,bus,X0),1004).
#show terminatedAt(punctuality(id75,bus,X0),1004).
