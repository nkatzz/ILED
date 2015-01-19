initiatedAt(internal_temperature(X,Y,very_cold),T):-
    happensAt(internal_temperature_change(X,Y,very_cold),T).

terminatedAt(internal_temperature(X,Y,very_cold),T):-
    happensAt(internal_temperature_change(X,Y,cold),T).
terminatedAt(internal_temperature(X,Y,very_cold),T):-
    happensAt(internal_temperature_change(X,Y,normal),T).
terminatedAt(internal_temperature(X,Y,very_cold),T):-
    happensAt(internal_temperature_change(X,Y,warm),T).
terminatedAt(internal_temperature(X,Y,very_cold),T):-
    happensAt(internal_temperature_change(X,Y,very_warm),T). 
