:- op(500,fy,#).
:- op(500,fy,*).




modeh(*,initiatedAt(driving_style(+vehicleId,+vehicleType,#fv_driving_style),+ttime)).
modeh(*,terminatedAt(driving_style(+vehicleId,+vehicleType,#fv_driving_style),+ttime)).


modeb(*,initiatedAt(sharp_turn(+vehicleId,+vehicleType,#fv_sharp_turn),+ttime)).
modeb(*,terminatedAt(sharp_turn(+vehicleId,+vehicleType,#fv_sharp_turn),+ttime)).
modeb(*,initiatedAt(abrupt_acceleration(+vehicleId,+vehicleType,#fv_abrupt_acceleration),+ttime)).
modeb(*,terminatedAt(abrupt_acceleration(+vehicleId,+vehicleType,#fv_abrupt_acceleration),+ttime)).
modeb(*,initiatedAt(abrupt_deceleration(+vehicleId,+vehicleType,#fv_abrupt_deceleration),+ttime)).
modeb(*,terminatedAt(abrupt_deceleration(+vehicleId,+vehicleType,#fv_abrupt_deceleration),+ttime)).





modeb(*,holdsAt(sharp_turn(+vehicleId,+vehicleType,#fv_sharp_turn),+ttime)).
modeb(*,holdsAt(abrupt_acceleration(+vehicleId,+vehicleType,#fv_abrupt_acceleration),+ttime)).
modeb(*,holdsAt(abrupt_deceleration(+vehicleId,+vehicleType,#fv_abrupt_deceleration),+ttime)).

modeb(*,not_holdsAt(sharp_turn(+vehicleId,+vehicleType,#fv_sharp_turn),+ttime)).
modeb(*,not_holdsAt(abrupt_acceleration(+vehicleId,+vehicleType,#fv_abrupt_acceleration),+ttime)).
modeb(*,not_holdsAt(abrupt_deceleration(+vehicleId,+vehicleType,#fv_abrupt_deceleration),+ttime)).


