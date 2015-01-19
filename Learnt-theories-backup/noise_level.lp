initiatedAt(noise_level(X,Y,high),T):-
    happensAt(noise_level_change(X,Y,high),T).
terminatedAt(noise_level(X,Y,high),T):-
    happensAt(noise_level_change(X,Y,low),T).
