
% A theory is loaded from here, variabilised and used as a prior hypothesis. This is for development & debugging.

%initiatedAt(fluent(fighting,id1,id2),10):-
%      happensAt(event(abrupt,id1),10).

terminatedAt(fluent(meeting,id1,id2),10):-
      happensAt(event(walking,id1),10), 
      notHoldsAt(close(id1,id2,20),10).
