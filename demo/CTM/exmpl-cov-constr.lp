:- example(holdsAt(driving_quality(X,Y,Z),T)), not holdsAt(driving_quality(X,Y,Z),T).
:- holdsAt(driving_quality(X,Y,Z),T), not example(holdsAt(driving_quality(X,Y,Z),T)).