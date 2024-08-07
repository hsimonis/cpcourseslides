:-lib(lists).
:-lib(ic).

top:-
    queens(8,Board),
    search(Board, 0, input_order, indomain, complete,[]),
	writeln(Board).
    
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