initiatedAt(driving_style(id75,bus,unsafe),350).

{term(X,vehicleId):initiatedAt(driving_style(X,_,_),_)}.
{term(X,vehicleType):initiatedAt(driving_style(_,X,_),_)}.
{term(X,ttime):initiatedAt(driving_style(_,_,_),X)}.
{term(X,vehicleId):terminatedAt(driving_style(X,_,_),_)}.
{term(X,vehicleType):terminatedAt(driving_style(_,X,_),_)}.
{term(X,ttime):terminatedAt(driving_style(_,_,_),X)}.
#hide.
#show term/2.
