happens(use(glucose),1) :- 
        holdsAt(available(glucose),1),
        holdsAt(available(lactose),1).

happens(use(lactose),2) :- 
        holdsAt(available(lactose),2),
        not_holdsAt(available(glucose),2).