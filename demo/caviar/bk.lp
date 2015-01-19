
holdsAt(F,Te) :-
       not sdFluent(F),
       initiatedAt(F,Ts),
       Te = Ts + 1,
       ttime(Ts),ttime(Te).

holdsAt(F,Te) :-
       not sdFluent(F),
       holdsAt(F,Ts),
       not terminatedAt(F,Ts),
       Te = Ts + 1,
       ttime(Ts),ttime(Te).

sdFluent(close(X,Y,Z)):-person(X),person(Y),threshold_value(Z).
sdFluent(orntdiff(X,Y,Z)):-person(X),person(Y),orientation_threshold(Z).
sdFluent(visible(X)):-person(X).
sdFluent(invisible(X)):-person(X).

%:-initiatedAt(fluent(F,X,Y),T),X = Y.
%:-terminatedAt(fluent(F,X,Y),T),X = Y. 
%:-initiatedAt(fluent(F,X,Y),T),not initiatedAt(fluent(F,Y,X),T).
%:-terminatedAt(fluent(F,X,Y),T),not terminatedAt(fluent(F,Y,X),T).



%fluent(F,X,Y):-
%       fluentName(F),person(X),person(Y),X!=Y.
        
%event(E,X):-
%    eventName(E),person(X).


person(X):-
    happensAt(event(_,X),_).

eventName(X):-
    happensAt(event(X,_),_).
 
ttime(T):-
    happensAt(event(_,_),T).

ttime(T):-
    example(holdsAt(_,T)). 

fluentName(moving).
fluentName(meeting).
fluentName(fighting).

not_happensAt(event(E,P),T):-
     not happensAt(event(E,P),T),
     eventName(E),person(P),ttime(T).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Distance
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

 
% Lua scripting language for arithmetic
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
       %XDiff := #abs(X),
       %YDiff := #abs(Y),
       %SideA := XDiff * XDiff,
       %SideB := YDiff * YDiff,
       %Temp := SideA + SideB,
       %Ypot := sqrt(Temp).
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


	
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Orientation & visibility
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

holdsAt(orntdiff(Id1,Id2,Threshold),Time):-
         Id1 != Id2,
         orientation(Id1,X,Time),
         orientation(Id2,Y,Time),
         %Diff := @absval(X,Y),
         Diff = #abs(X-Y),
         orientation_threshold(Threshold), 
         Diff <= Threshold,
         person(Id1),person(Id2),ttime(Time). 


notHoldsAt(orntdiff(Id1,Id2,Threshold),Time):-
             Id1 != Id2,
             orientation(Id1,X,Time),
             orientation(Id2,Y,Time),
             %Diff := @absval(X,Y),
             Diff = #abs(X-Y),
             orientation_threshold(Threshold), 
             Diff > Threshold,
             person(Id1),person(Id2),ttime(Time).

              


%*** This works with real caviar only ***%

%holdsAt(visible(X),T):-
%               appearance(X,visible,T).
%
%holdsAt(invisible(X),T):-
%               person(X),ttime(T),
%               not appearance(X,visible,T).
%



holdsAt(visible(X),T):-
            holdsAt(visible,X,T).

holdsAt(invisible(X),T):-
            holdsAt(invisible,X,T).




%orientation_threshold(0..1000).
%orientation_threshold(10).
%orientation_threshold(20).
%orientation_threshold(5).
%orientation_threshold(30).
%orientation_threshold(40).
%orientation_threshold(50).
orientation_threshold(45).
%orientation_threshold(100).
%orientation_threshold(200).
%orientation_threshold(300).
%orientation_threshold(360).

threshold_value(40). %move
threshold_value(30). %meet
threshold_value(20). %fight      

%threshold_value(20).
%threshold_value(23).
%threshold_value(25).
%threshold_value(27).
%threshold_value(30).
       

#hide.

