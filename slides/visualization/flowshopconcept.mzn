% variables
	array[T] of var 0..ub:start;
	var lb..ub:cmax;
	
% constraints
	constraint forall (i in T)
               (cmax >= start[i]+duration[i]);
	constraint forall (p in P)
               (start[prec[p,2]] >= start[prec[p,1]]+
                                          duration[prec[p,1]]);
	constraint forall(s in S) 
	    (cumulative([start[i]|i in T where stage[i]=s],
	                [duration[i]|i in T where stage[i] = s],
	                [1|i in T where stage[i] = s],1));
	constraint 
	    cumulative([start[i]|i in T],
	                [manpowerDuration[i]|i in T],
	                [1|i in T],manpower);

solve minimize cmax;

	