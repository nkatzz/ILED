:- op(500,fy,#).
:- op(500,fy,*).

modeh(*,initiatedAt(fluent(#fluentName,+person,+person),+ttime)).
modeh(*,terminatedAt(fluent(#fluentName,+person,+person),+ttime)).

modeb(*,holdsAt(close(+person,-person,#threshold_value),+ttime)).
modeb(*,holdsAt(close(-person,+person,#threshold_value),+ttime)).
modeb(*,happensAt(event(#eventName,-person),+ttime)).
%modeb(*,not happensAt(event(#eventName,-person),+ttime)).
modeb(*,holdsAt(visible(-person),+ttime)).
modeb(*,holdsAt(invisible(-person),+ttime)).
modeb(*,holdsAt(orntdiff(+person,-person,#orientation_threshold),+ttime)).
modeb(*,holdsAt(orntdiff(-person,+person,#orientation_threshold),+ttime)).

%modeb(*,not holdsAt(orntdiff(+person,-person,#orientation_threshold),+ttime)).
%modeb(*,not holdsAt(orntdiff(-person,+person,#orientation_threshold),+ttime)).
%modeb(*,notHoldsAt(orntdiff(+person,-person,#orientation_threshold),+ttime)).
%modeb(*,notHoldsAt(orntdiff(-person,+person,#orientation_threshold),+ttime)).
modeb(*,notHoldsAt(close(+person,-person,#threshold_value),+ttime)).
modeb(*,notHoldsAt(close(-person,+person,#threshold_value),+ttime)).


%modeb(*,not happens(event(#eventName,-person),+ttime)).
%modeb(*,notHoldsAt(close(+person,-person,#threshold_value),+ttime)).
%modeb(*,notHoldsAt(orntdiff(+person,-person,#orientation_threshold),+ttime)).
%modeb(*,happensAt(disappears(+person),-ttime)).
%modeb(*,holdsAt(fluent(#fluentName,+person,+person),+ttime)).








