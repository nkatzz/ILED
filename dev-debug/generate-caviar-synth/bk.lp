
holdsAt(fluent(F,X,Y),Te):-
          fluentName(F),person(X),person(Y),
          Te = Ts + 1, 
          initiatedAt(fluent(F,X,Y),Ts),
          ttime(Ts),ttime(Te). 

holdsAt(fluent(F,X,Y),Te):-
          fluentName(F),person(X),person(Y),
          Te = Ts + 1,
          holdsAt(fluent(F,X,Y),Ts),
          not terminatedAt(fluent(F,X,Y),Ts),
          ttime(Ts),ttime(Te).



%:-initiatedAt(fluent(F,X,Y),T),X = Y.
%:-terminatedAt(fluent(F,X,Y),T),X = Y. 

% Just to make sure that data generation will fail is this happens:

:-initiatedAt(fluent(F,X,Y),T),not initiatedAt(fluent(F,Y,X),T).
:-terminatedAt(fluent(F,X,Y),T),not terminatedAt(fluent(F,Y,X),T).

fluent(F,X,Y):-
       fluentName(F),person(X),person(Y),X!=Y.
        
event(E,X):-
    eventName(E),person(X).

not_happensAt(event(E,P),T):-
     not happensAt(event(E,P),T),
     eventName(E),person(P),ttime(T).


#begin_lua
function eucldist(x1,y1,x2,y2)
   x = x1 - x2
   y = y1 - y2
   xDiff = math.abs(x)
   yDiff = math.abs(y)
   sideA = xDiff * xDiff
   sideB = yDiff * yDiff
   temp = sideA + sideB
   ypot = math.sqrt(temp)
   return ypot
end

function absval(x,y)
   z = x-y
   res = math.abs(z)
   return z
end
#end_lua. 
	

dist(Id1,Id2,T,Ypot):-
       coords(Id1,X1,Y1,T),
       coords(Id2,X2,Y2,T),
       Id1 != Id2,
       X := X1-X2,
       Y := Y1-Y2,
       Ypot := @eucldist(X1,Y1,X2,Y2).

holdsAt(close(Id1,Id2,Threshold),Time):-
                 dist(Id1,Id2,Time,Distance),
                 Id1 != Id2,
                 threshold_value(Threshold),
                 Distance <= Threshold,
                 person(Id1),person(Id2),ttime(Time).

notHoldsAt(close(Id1,Id2,Threshold),Time):-
                 dist(Id1,Id2,Time,Distance),
                 Id1 != Id2,
                 threshold_value(Threshold),
                 Distance > Threshold,
                 person(Id1),person(Id2),ttime(Time).



holdsAt(orntdiff(Id1,Id2,Threshold),Time):-
         Id1 != Id2,
         orientation(Id1,X,Time),
         orientation(Id2,Y,Time),
         %Diff := @absval(X,Y), %% This causes problems! I have not figured out why... For example in the data generation
                                %% if this is used the constraint :-holdsAt(fluent(F,X,Y),T),not holdsAt(fluent(F,Y,X),T).
                                %% cannot be satisfied.
         Diff = #abs(X-Y),
         orientation_threshold(Threshold), 
         Diff <= Threshold,
         person(Id1),person(Id2),ttime(Time). 

notHoldsAt(orntdiff(Id1,Id2,Threshold),Time):-
             Id1 != Id2,
             orientation(Id1,X,Time),
             orientation(Id2,Y,Time),
             %Diff := @absval(X,Y), %% This causes problems! 
             Diff = #abs(X-Y),
             orientation_threshold(Threshold), 
             Diff > Threshold,
             person(Id1),person(Id2),ttime(Time).
              

%orientation_threshold(0..1000).
orientation_threshold(10).
orientation_threshold(20).
orientation_threshold(5).
orientation_threshold(30).
orientation_threshold(40).
orientation_threshold(50).
orientation_threshold(45).
threshold_value(40). %move
threshold_value(30). %meet
threshold_value(20). %fight      
eventName(running).
eventName(walking).
eventName(walking1).
eventName(walking2).
eventName(active).
eventName(abrupt).
eventName(abrupt1).
eventName(abrupt2).
eventName(inactive).
fluentName(moving).
fluentName(meeting).
fluentName(fighting).
person(id1).
person(id2).



%*** FIGHTING ****%








initiatedAt(fluent(fighting,X,Y),T):-
            holdsAt(visible,X,T),
            holdsAt(visible,Y,T),
            happensAt(event(abrupt,X),T),
            happensAt(event(abrupt,Y),T),
            holdsAt(close(X,Y,20),T),
            person(X),person(Y),ttime(T).

initiatedAt(fluent(fighting,X,Y),T):-
            holdsAt(visible,X,T),
            holdsAt(visible,Y,T),
            happensAt(event(abrupt1,X),T),
            happensAt(event(abrupt1,Y),T),
            holdsAt(close(X,Y,20),T),
            person(X),person(Y),ttime(T).

initiatedAt(fluent(fighting,X,Y),T):-
            holdsAt(visible,X,T),
            holdsAt(visible,Y,T),
            happensAt(event(abrupt2,X),T),
            happensAt(event(abrupt2,Y),T),
            holdsAt(close(X,Y,20),T),
            person(X),person(Y),ttime(T).

initiatedAt(fluent(fighting,X,Y),T):-
            holdsAt(visible,X,T),
            holdsAt(visible,Y,T),
            happensAt(event(abrupt1,X),T),
            happensAt(event(abrupt2,Y),T),
            holdsAt(close(X,Y,20),T),
            person(X),person(Y),ttime(T).

initiatedAt(fluent(fighting,X,Y),T):-
            holdsAt(visible,X,T),
            holdsAt(visible,Y,T),
            happensAt(event(abrupt1,Y),T),
            happensAt(event(abrupt2,X),T),
            holdsAt(close(X,Y,20),T),
            person(X),person(Y),ttime(T).

initiatedAt(fluent(fighting,X,Y),T):-
            holdsAt(visible,X,T),
            holdsAt(visible,Y,T),
            happensAt(event(abrupt2,X),T),
            happensAt(event(abrupt1,Y),T),
            holdsAt(close(X,Y,20),T),
            person(X),person(Y),ttime(T).

initiatedAt(fluent(fighting,X,Y),T):-
            holdsAt(visible,X,T),
            holdsAt(visible,Y,T),
            happensAt(event(abrupt2,Y),T),
            happensAt(event(abrupt1,X),T),
            holdsAt(close(X,Y,20),T),
            person(X),person(Y),ttime(T).

initiatedAt(fluent(moving,X,Y),T):-
            holdsAt(visible,X,T),
            holdsAt(visible,Y,T), 
            happensAt(event(walking,X),T),
            happensAt(event(walking,Y),T),
            holdsAt(close(X,Y,40),T), 
            holdsAt(orntdiff(X,Y,45),T),
            person(X),person(Y),ttime(T). 

initiatedAt(fluent(moving,X,Y),T):-
            holdsAt(visible,X,T),
            holdsAt(visible,Y,T), 
            happensAt(event(walking1,X),T),
            happensAt(event(walking2,Y),T),
            holdsAt(close(X,Y,40),T), 
            holdsAt(orntdiff(X,Y,45),T),
            person(X),person(Y),ttime(T). 

initiatedAt(fluent(moving,X,Y),T):-
            holdsAt(visible,X,T),
            holdsAt(visible,Y,T), 
            happensAt(event(walking1,Y),T),
            happensAt(event(walking2,X),T),
            holdsAt(close(X,Y,40),T), 
            holdsAt(orntdiff(X,Y,45),T),
            person(X),person(Y),ttime(T). 

initiatedAt(fluent(moving,X,Y),T):-
            holdsAt(visible,X,T),
            holdsAt(visible,Y,T), 
            happensAt(event(walking2,X),T),
            happensAt(event(walking1,Y),T),
            holdsAt(close(X,Y,40),T), 
            holdsAt(orntdiff(X,Y,45),T),
            person(X),person(Y),ttime(T). 

initiatedAt(fluent(moving,X,Y),T):-
            holdsAt(visible,X,T),
            holdsAt(visible,Y,T), 
            happensAt(event(walking2,Y),T),
            happensAt(event(walking1,X),T),
            holdsAt(close(X,Y,40),T), 
            holdsAt(orntdiff(X,Y,45),T),
            person(X),person(Y),ttime(T). 

initiatedAt(fluent(moving,X,Y),T):-
            holdsAt(visible,X,T),
            holdsAt(visible,Y,T), 
            happensAt(event(walking,X),T),
            happensAt(event(active,Y),T),
            holdsAt(close(X,Y,40),T), 
            holdsAt(orntdiff(X,Y,45),T),
            person(X),person(Y),ttime(T).

initiatedAt(fluent(moving,X,Y),T):-
            holdsAt(visible,X,T),
            holdsAt(visible,Y,T), 
            happensAt(event(active,X),T),
            happensAt(event(walking,Y),T),
            holdsAt(close(X,Y,40),T), 
            holdsAt(orntdiff(X,Y,45),T),
            person(X),person(Y),ttime(T).


initiatedAt(fluent(meeting,X,Y),T):-
            holdsAt(visible,X,T),
            holdsAt(visible,Y,T), 
            happensAt(event(active,X),T),
            happensAt(event(active,Y),T),
            holdsAt(close(X,Y,30),T), 
            person(X),person(Y),ttime(T). 

 


initiatedAt(fluent(meeting,X,Y),T):-
            holdsAt(visible,X,T),
            holdsAt(visible,Y,T), 
            happensAt(event(active,X),T),
            happensAt(event(inactive,Y),T),
            holdsAt(close(X,Y,30),T), 
            person(X),person(Y),ttime(T). 

initiatedAt(fluent(meeting,X,Y),T):-
            holdsAt(visible,X,T),
            holdsAt(visible,Y,T), 
            happensAt(event(inactive,X),T),
            happensAt(event(active,Y),T),
            holdsAt(close(X,Y,30),T), 
            person(X),person(Y),ttime(T). 





%:-holdsAt(fluent(F1,X,Y),T),holdsAt(fluent(F2,X,Y),T),F1 != F2.
%:-holdsAt(fluent(F,X,Y),T),not holdsAt(fluent(F,Y,X),T).
%:-holdsAt(close(X,Y,Tr),T),not holdsAt(close(Y,X,Tr),T). %% This works fine, it's just not needed. 

#hide.
#show holdsAt(fluent(F,X,Y),T).
%#show initiatedAt(fluent(F,X,Y),T).
%#show terminatedAt(fluent(F,X,Y),T).


