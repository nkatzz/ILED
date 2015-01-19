:- example(holdsAt(driving_style(X,Y,Z),T)), not holdsAt(driving_style(X,Y,Z),T).
:- holdsAt(driving_style(X,Y,Z),T), not example(holdsAt(driving_style(X,Y,Z),T)).