:- example(holdsAt(fluent(X,Y,Z),T)), not holdsAt(fluent(X,Y,Z),T).
:- holdsAt(fluent(X,Y,Z),T), not example(holdsAt(fluent(X,Y,Z),T)).