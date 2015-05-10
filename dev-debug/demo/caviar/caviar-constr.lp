
:-initiatedAt(fluent(F,X,Y),T),X = Y.
:-terminatedAt(fluent(F,X,Y),T),X = Y. 
:-initiatedAt(fluent(F,X,Y),T),not initiatedAt(fluent(F,Y,X),T).
:-terminatedAt(fluent(F,X,Y),T),not terminatedAt(fluent(F,Y,X),T).
