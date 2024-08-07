:-lib(lists).
:-lib(ic).

top:-
    member(Reorder,[no,yes]),
	member(VarSelect,[input_order,first_fail]),
	member(ValueSelect,[indomain,indomain_min,indomain_middle,indomain_random]),
	member(Search,[complete,credit(100,bbs(5)),lds(3),dbs(3,bbs(5))]),
    (
		VarSelect = input_order,ValueSelect=indomain_random
	;
		VarSelect = first_fail
	),
    once((for(N,4,200),
	 foreach(B,Bt),
	 fromto(0,BB,BB1,BTotal),
	 fromto(0,FF,FF1,FTotal),
     param(Reorder,VarSelect,ValueSelect,Search) do
		queens(N,Board),
		reorder(Board,L),
		(Reorder = yes ->
		    Vars = L
		;
			Vars = Board
		),

		(search(Vars, 0, VarSelect, ValueSelect,Search,[backtrack(B),nodes(10000)]) ->
%			writeln(N-B-Board),
			BB1 is BB+B,
			FF1 = FF
			;
%			writeln(no_solution_found(N)),
			B = '-',
			BB1 = BB,
			FF1 is FF+1
		)
	)),
	writeq(count(FTotal,BTotal,Reorder,VarSelect,ValueSelect,Search,Bt)),nl,
	fail.
top.
	
    
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