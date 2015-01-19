not_happensAt(my_stop_leave(id75,bus,stopId,late),1004).

{term(X,stopId):not_happensAt(my_stop_leave(_,_,X,_),_)}.
{term(X,fv_my_stop_leave):not_happensAt(my_stop_leave(_,_,_,X),_)}.
#hide.
#show term/2.
