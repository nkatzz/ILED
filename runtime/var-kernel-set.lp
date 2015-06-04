happens(use(glucose),X1) :- 
        holdsAt(available(glucose),X1),
        holdsAt(available(lactose),X1).

happens(use(lactose),X1) :- 
        holdsAt(available(lactose),X1),
        not_holdsAt(available(glucose),X1).