tp1(N) :- N = #count{example(holdsAt(fluent(X,Y,Z),T)):holdsAt(fluent(X,Y,Z),T)}, N > 0.
fp1(N) :- N = #count{holdsAt(fluent(X,Y,Z),T):not example(holdsAt(fluent(X,Y,Z),T))}, N > 0.
fn1(N) :- N = #count{example(holdsAt(fluent(X,Y,Z),T)):not holdsAt(fluent(X,Y,Z),T)}, N > 0.


fpp(X,Y,Z,T) :- holdsAt(fluent(X,Y,Z),T),not example(holdsAt(fluent(X,Y,Z),T)).

positives(N) :- N = #count{example(_)}, N > 0.
#hide.
#show tp1(N).
#show fp1(N).
#show fn1(N).
#show positives/1.
#show fpp(X,Y,Z,T).
