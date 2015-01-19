
holdsAt(F,Te) :-
       initiatedAt(F,Ts),
       Te = Ts + 1,
       ttime(Ts),ttime(Te).

holdsAt(F,Te) :-
       holdsAt(F,Ts),
       not terminatedAt(F,Ts),
       Te = Ts + 1,
       ttime(Ts),ttime(Te).

holdsAt(F,T) :-
       starttime(T),
       example(holdsAt(F,T)).
 
% Extra BK:

initiatedAt(sharp_turn(X,Y,Z),T):-
    happensAt(sharp_turn_start(X,Y,Z),T).
terminatedAt(sharp_turn(X,Y,Z),T):-
    happensAt(sharp_turn_end(X,Y,Z),T).
initiatedAt(abrupt_acceleration(X,Y,Z),T):-
    happensAt(abrupt_acceleration_start(X,Y,Z),T).
terminatedAt(abrupt_acceleration(X,Y,Z),T):-
    happensAt(abrupt_acceleration_end(X,Y,Z),T).
initiatedAt(abrupt_deceleration(X,Y,Z),T):-
    happensAt(abrupt_deceleration_start(X,Y,Z),T).
terminatedAt(abrupt_deceleration(X,Y,Z),T):-
    happensAt(abrupt_deceleration_end(X,Y,Z),T).


initiatedAt(passenger_density(X,Y,high),T):-
    happensAt(passenger_density_change(X,Y,high),T).
terminatedAt(passenger_density(X,Y,high),T):-
    happensAt(passenger_density_change(X,Y,low),T).
    

initiatedAt(noise_level(X,Y,high),T):-
    happensAt(noise_level_change(X,Y,high),T).
terminatedAt(noise_level(X,Y,high),T):-
    happensAt(noise_level_change(X,Y,low),T).
    

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


terminatedAt(punctuality(X3,X1,non_punctual),X2) :- 
        happensAt(my_stop_enter(X3,X1,stopId,early),X2).
initiatedAt(punctuality(X3,X1,punctual),X2) :- 
        happensAt(my_stop_enter(X3,X1,stopId,early),X2).
terminatedAt(punctuality(X3,X1,non_punctual),X2) :- 
        happensAt(my_stop_enter(X3,X1,stopId,scheduled),X2).
terminatedAt(punctuality(X2,X1,punctual),X3) :- 
        happensAt(my_stop_enter(X2,X1,stopId,late),X3).
initiatedAt(punctuality(X3,X1,non_punctual),X2) :- 
        happensAt(my_stop_leave(X3,X1,stopId,early),X2).
initiatedAt(punctuality(X2,X1,non_punctual),X3) :- 
        happensAt(my_stop_enter(X2,X1,stopId,late),X3).
terminatedAt(punctuality(X3,X1,punctual),X2) :- 
        happensAt(my_stop_leave(X3,X1,stopId,early),X2).
initiatedAt(punctuality(X3,X1,punctual),X2) :- 
        happensAt(my_stop_enter(X3,X1,stopId,scheduled),X2).




:-initiatedAt(driving_quality(A,B,C),D),terminatedAt(driving_quality(A,B,C),D).
:-initiatedAt(passenger_satisfaction(A,B,C),D),terminatedAt(passenger_satisfaction(A,B,C),D).
:-initiatedAt(driving_style(A,B,C),D),terminatedAt(driving_style(A,B,C),D).
:-initiatedAt(punctuality(A,B,C),D),terminatedAt(punctuality(A,B,C),D).
:-initiatedAt(sharp_turn(A,B,C),D),terminatedAt(sharp_turn(A,B,C),D).
:-initiatedAt(abrupt_acceleration(A,B,C),D),terminatedAt(abrupt_acceleration(A,B,C),D).
:-initiatedAt(abrupt_deceleration(A,B,C),D),terminatedAt(abrupt_deceleration(A,B,C),D).
:-initiatedAt(passenger_density(A,B,C),D),terminatedAt(passenger_density(A,B,C),D).
:-initiatedAt(noise_level(A,B,C),D),terminatedAt(noise_level(A,B,C),D).
:-initiatedAt(internal_temperature(A,B,C),D),terminatedAt(internal_temperature(A,B,C),D).




vehicleId(VehicleId):-
        happensAt(abrupt_acceleration_start(VehicleId,_,_),_).
vehicleId(VehicleId):-
        happensAt(abrupt_acceleration_end(VehicleId,_,_),_).
vehicleId(VehicleId):-
        happensAt(abrupt_deceleration_start(VehicleId,_,_),_).
vehicleId(VehicleId):-
        happensAt(abrupt_deceleration_end(VehicleId,_,_),_).
vehicleId(VehicleId):-
        happensAt(sharp_turn_start(VehicleId,_,_),_).
vehicleId(VehicleId):-
        happensAt(sharp_turn_end(VehicleId,_,_),_).
vehicleId(VehicleId):-
        happensAt(internal_temperature_change(VehicleId,_,_),_).
vehicleId(VehicleId):-
        happensAt(noise_level_change(VehicleId,_,_),_).
vehicleId(VehicleId):-
        happensAt(passenger_density_change(VehicleId,_,_),_).
vehicleId(VehicleId):-
        happensAt(stop_enter(VehicleId,_,_,_),_).
vehicleId(VehicleId):-
        happensAt(stop_leave(VehicleId,_,_,_),_).

vehicleType(VehicleType):-
        happensAt(abrupt_acceleration_start(_,VehicleType,_),_).
vehicleType(VehicleType):-
        happensAt(abrupt_acceleration_end(_,VehicleType,_),_).
vehicleType(VehicleType):-
        happensAt(abrupt_deceleration_start(_,VehicleType,_),_).
vehicleType(VehicleType):-
        happensAt(abrupt_deceleration_end(_,VehicleType,_),_).
vehicleType(VehicleType):-
        happensAt(sharp_turn_start(_,VehicleType,_),_).
vehicleType(VehicleType):-
        happensAt(sharp_turn_end(_,VehicleType,_),_).
vehicleType(VehicleType):-
        happensAt(internal_temperature_change(_,VehicleType,_),_).
vehicleType(VehicleType):-
        happensAt(noise_level_change(_,VehicleType,_),_).
vehicleType(VehicleType):-
        happensAt(passenger_density_change(_,VehicleType,_),_).
vehicleType(VehicleType):-
        happensAt(stop_enter(_,VehicleType,_,_),_).
vehicleType(VehicleType):-
        happensAt(stop_leave(_,VehicleType,_,_),_).

evalue(V):-
        happensAt(abrupt_acceleration_start(_,_,V),_).
evalue(V):-
        happensAt(abrupt_acceleration_end(_,_,V),_).
evalue(V):-
        happensAt(abrupt_deceleration_start(_,_,V),_).
evalue(V):-
        happensAt(abrupt_deceleration_end(_,_,V),_).
evalue(V):-
        happensAt(internal_temperature_change(_,_,V),_).
evalue(V):-
        happensAt(noise_level_change(_,_,V),_).
evalue(V):-
        happensAt(passenger_density_change(_,_,V),_).
evalue(V):-
        happensAt(sharp_turn_start(_,_,V),_).
evalue(V):-
        happensAt(sharp_turn_end(_,_,V),_).
evalue(V):-
        happensAt(stop_enter(_,_,_,V),_).
evalue(V):-
        happensAt(stop_leave(_,_,_,V),_).


happensAt(my_stop_enter(VId,VType,stopId,Value),T):-
        happensAt(stop_enter(VId,VType,_,Value),T). 

happensAt(my_stop_leave(VId,VType,stopId,Value),T):-
        happensAt(stop_leave(VId,VType,_,Value),T).


stopId(S):-
        happensAt(my_stop_enter(_,_,S,_),_).
stopId(S):-
        happensAt(my_stop_leave(_,_,S,_),_).





ttime(T):-
        happensAt(_,T).
ttime(T):-
        example(holdsAt(_,T)).



 
fv_passenger_satisfaction(reducing).

fv_driving_quality(low).

fv_driving_style(unsafe).

fv_passenger_density(high).
fv_passenger_density(low).

fv_noise_level(high).
fv_noise_level(low).

fv_sharp_turn(sharp).
fv_sharp_turn(very_sharp).

fv_punctuality(punctual).
fv_punctuality(non_punctual).

fv_abrupt_acceleration(abrupt).
fv_abrupt_acceleration(very_abrupt).
fv_abrupt_deceleration(abrupt).
fv_abrupt_deceleration(very_abrupt).

fv_internal_temperature(very_cold).
fv_internal_temperature(cold).
fv_internal_temperature(normal).
fv_internal_temperature(warm).
fv_internal_temperature(very_warm).



#hide.
	


%#show ttime/1.
%#show vehicleType/1.
%#show vehicleId/1.
%#show holdsAt/2.
%#show ttime/1.

