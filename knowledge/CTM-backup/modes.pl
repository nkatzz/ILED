:- op(500,fy,#).
:- op(500,fy,*).

%% I'll have to find a solution for the flvalues representation



%modeh(*,initiatedAt(passenger_satisfaction(+vehicleId,+vehicleType,#fv_passenger_satisfaction),+ttime)).
%modeh(*,terminatedAt(passenger_satisfaction(+vehicleId,+vehicleType,#fv_passenger_satisfaction),+ttime)).
%modeh(*,initiatedAt(driving_quality(+vehicleId,+vehicleType,#fv_driving_quality),+ttime)).
%modeh(*,terminatedAt(driving_quality(+vehicleId,+vehicleType,#fv_driving_quality),+ttime)).

modeh(*,initiatedAt(driving_style(+vehicleId,+vehicleType,#fv_driving_style),+ttime)).
modeh(*,terminatedAt(driving_style(+vehicleId,+vehicleType,#fv_driving_style),+ttime)).

%modeh(*,initiatedAt(punctuality(+vehicleId,+vehicleType,#fv_punctuality),+ttime)).
%modeh(*,terminatedAt(punctuality(+vehicleId,+vehicleType,#fv_punctuality),+ttime)).
%modeh(*,initiatedAt(sharp_turn(+vehicleId,+vehicleType,#fv_sharp_turn),+ttime)).
%modeh(*,terminatedAt(sharp_turn(+vehicleId,+vehicleType,#fv_sharp_turn),+ttime)).
%modeh(*,initiatedAt(abrupt_acceleration(+vehicleId,+vehicleType,#fv_abrupt_acceleration),+ttime)).
%modeh(*,terminatedAt(abrupt_acceleration(+vehicleId,+vehicleType,#fv_abrupt_acceleration),+ttime)).
%modeh(*,initiatedAt(abrupt_deceleration(+vehicleId,+vehicleType,#fv_abrupt_deceleration),+ttime)).
%modeh(*,terminatedAt(abrupt_deceleration(+vehicleId,+vehicleType,#fv_abrupt_deceleration),+ttime)).
%modeh(*,initiatedAt(passenger_density(+vehicleId,+vehicleType,#fv_passenger_density),+ttime)).
%modeh(*,terminatedAt(passenger_density(+vehicleId,+vehicleType,#fv_passenger_density),+ttime)).
%modeh(*,initiatedAt(noise_level(+vehicleId,+vehicleType,#fv_noise_level),+ttime)).
%modeh(*,terminatedAt(noise_level(+vehicleId,+vehicleType,#fv_noise_level),+ttime)).
%modeh(*,initiatedAt(internal_temperature(+vehicleId,+vehicleType,#fv_internal_temperature),+ttime)).
%modeh(*,terminatedAt(internal_temperature(+vehicleId,+vehicleType,#fv_internal_temperature),+ttime)).

modeb(*,happensAt(abrupt_acceleration_start(+vehicleId,+vehicleType,#evalue),+ttime)).
modeb(*,happensAt(abrupt_acceleration_end(+vehicleId,+vehicleType,#evalue),+ttime)).
modeb(*,happensAt(abrupt_deceleration_start(+vehicleId,+vehicleType,#evalue),+ttime)).
modeb(*,happensAt(abrupt_deceleration_end(+vehicleId,+vehicleType,#evalue),+ttime)).
modeb(*,happensAt(internal_temperature_change(+vehicleId,+vehicleType,#evalue),+ttime)).
modeb(*,happensAt(noise_level_change(+vehicleId,+vehicleType,#evalue),+ttime)).
modeb(*,happensAt(passenger_density_change(+vehicleId,+vehicleType,#evalue),+ttime)).
modeb(*,happensAt(sharp_turn_start(+vehicleId,+vehicleType,#evalue),+ttime)).
modeb(*,happensAt(sharp_turn_end(+vehicleId,+vehicleType,#evalue),+ttime)).
modeb(*,happensAt(my_stop_enter(+vehicleId,+vehicleType,#stopId,#evalue),+ttime)).
modeb(*,happensAt(my_stop_leave(+vehicleId,+vehicleType,#stopId,#evalue),+ttime)).

modeb(*,holdsAt(sharp_turn(+vehicleId,+vehicleType,#fv_sharp_turn),+ttime)).
modeb(*,holdsAt(abrupt_acceleration(+vehicleId,+vehicleType,#fv_abrupt_acceleration),+ttime)).
modeb(*,holdsAt(abrupt_deceleration(+vehicleId,+vehicleType,#fv_abrupt_deceleration),+ttime)).
modeb(*,holdsAt(passenger_density(+vehicleId,+vehicleType,#fv_passenger_density),+ttime)).
modeb(*,holdsAt(noise_level(+vehicleId,+vehicleType,#fv_noise_level),+ttime)).
modeb(*,holdsAt(internal_temperature(+vehicleId,+vehicleType,#fv_internal_temperature),+ttime)).

modeb(*,holdsAt(passenger_satisfaction(+vehicleId,+vehicleType,#fv_passenger_satisfaction),+ttime)).
modeb(*,holdsAt(driving_quality(+vehicleId,+vehicleType,#fv_driving_quality),+ttime)).
modeb(*,holdsAt(driving_style(+vehicleId,+vehicleType,#fv_driving_style),+ttime)).
modeb(*,holdsAt(punctuality(+vehicleId,+vehicleType,#fv_punctuality),+ttime)).


