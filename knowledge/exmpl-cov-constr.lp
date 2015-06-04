:- example(holdsAt(available(X),Y)), not holdsAt(available(X),Y).
:- holdsAt(available(X),Y), not example(holdsAt(available(X),Y)).