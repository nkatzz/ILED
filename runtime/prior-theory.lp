happens(use(lactose),X1) :- 
        holdsAt(available(lactose),X1),
        not_holdsAt(available(glucose),X1),
        time(X1).

happens(use(glucose),X1) :- 
        holdsAt(available(glucose),X1),
        time(X1).



