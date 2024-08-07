:-module(repaired).

:-export(top/0).

:- lib(tentative).
:- lib(util).
:- lib(tentative_constraints).

top:-
        between(10000,10010,Size),
        Start is cputime,
        once(queens(Size,_X)),
        Time is cputime-Start,
        writeln(Size-Time),
        fail.


    queens(N, Board) :-
	    dim(Board, [N]),			% make variables
	    tent_set_random(Board, 1..N),	% init tentative values

	    dim(Pos, [N]),			% aux arrays of constants
	    ( foreacharg(I,Pos), for(I,0,N-1) do true ),
	    dim(Neg, [N]),
	    ( foreacharg(I,Neg), for(I,0,-N+1,-1) do true ),

	    CS :~ alldifferent(Board),		% setup constraints ...
	    CS :~ alldifferent(Board, Pos),	% ... in conflict set CS
	    CS :~ alldifferent(Board, Neg),

	    cs_violations(CS, TotalViolation),	% search part
	    steepest(Board, N, TotalViolation),

	    tent_fix(Board),			% instantiate variables
	    cs_clear_satisfied(CS).		% clean up conflict set


    steepest(Board, N, Violations) :-
	    vs_create(Board, Vars),		% create variable set
	    Violations tent_get V0,		% initial violations
	    SampleSize is fix(sqrt(N)),		% neighbourhood size
	    (
		fromto(V0,_V1,V2,0),		% until no violations left
		param(Vars,N,SampleSize,Violations)
	    do
		vs_random_worst(Vars, X),		% get a most violated variable
		tent_minimize_random(		% find a best neighbour
		    (				% nondeterministic move
			random_sample(1..N,SampleSize,I),
			X tent_set I
		    ),
		    Violations,			% violation variable
		    I				% best move-id
		),
		X tent_set I,			% do the move
		Violations tent_get V2		% new violations
	    ).
