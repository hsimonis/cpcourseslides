include "globals.mzn";
int:nrJobs;
int:nrRes;
set of int: J=1..nrJobs;
set of int: R=1..nrRes;
array[J,R] of int:taskUse;
array[J,R] of int:taskDuration;
include "mt10.dzn";
int:ub =1000;

array[J,R] of var 0..ub:start;
var 0..ub:objective;
constraint forall(j in J) 
   (objective >= start[j,nrRes]+taskDuration[j,nrRes]);
 constraint forall(j in J, r in 1..nrRes-1)
  (start[j,r+1] >= start[j,r]+taskDuration[j,r]);
  constraint forall (r in R)
    (cumulative([start[j,k]|j in J, k in R where taskUse[j,k]+1=r],
                            [taskDuration[j,k]|j in J, k in R where taskUse[j,k]+1=r],
                            [1|j in J, k in R where taskUse[j,k]+1=r],1)
    );
   
solve minimize objective;
