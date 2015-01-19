initiatedAt(passenger_density(X,Y,high),T):-
    happensAt(passenger_density_change(X,Y,high),T).
terminatedAt(passenger_density(X,Y,high),T):-
    happensAt(passenger_density_change(X,Y,low),T).
