:-lib(lists).
:-lib(ic).

top:-
    (for(N,4,100) do
		queens(N,Board),
		(search(Board, 0, input_order, indomain, complete,[nodes(100000),backtrack(B)]) ->
			writeln(N-B-Board)
			;
			writeln(no_solution_found(N))
		)
	).
    
queens(N, Board) :-
    length(Board, N),
    Board :: 1..N,
    ( fromto(Board, [Q1|Cols], Cols, []) do
        ( foreach(Q2, Cols), 
		  param(Q1), 
		  count(Dist,1,_) do
            noattack(Q1, Q2, Dist)
        )
    ).

noattack(Q1,Q2,Dist) :-
    Q2 #\= Q1,
    Q2 - Q1 #\= Dist,
    Q1 - Q2 #\= Dist.