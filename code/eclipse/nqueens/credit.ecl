:-lib(lists).
:-lib(ic).

top:-
    (for(N,4,200) do
		queens(N,Board),
%		reorder(Board,L),
		(search(Board, 0, input_order, indomain, credit(N,bbs(5)),[backtrack(B)]) ->
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
	
reorder(L,L1):-
	halve(L,L,[],Front,Tail),
	combine(Front,Tail,L1).

halve([],Tail,Front,Front,Tail).
halve([_],Tail,Front,Front,Tail).
halve([_,_|R],[F|T],Front,Fend,Tail):-
	halve(R,T,[F|Front],Fend,Tail).

combine(C,[],C):-!.
combine([],C,C).
combine([A|A1],[B|B1],[B,A|C1]):-
	combine(A1,B1,C1).