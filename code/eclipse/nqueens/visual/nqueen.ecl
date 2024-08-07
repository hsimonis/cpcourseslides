:- module(nqueen).

:-comment(summary,"This is the well-known nqueens problem as a finite domain model").
:-comment(author,"Helmut Simonis").

:-export(top/0).

:-lib(ic).
:-lib(timeout).

:-comment(top/0,[
	summary:"entry point for nqueens program, run all sizes from 4 to 100",
	desc:html("This is the entry point for running the nqueens program. 
It will run all sizes from 4 to 100 to find a first solution. 
A timeout is used to limit individual runs to 10 seconds. 
The program prints the size and solution for each size, 
and prints timeout when a timeout occurs.")]).

top:-
    (for(J,4,100) do
    	nqueen(J,L),
    	writeln(J-L)
    ).
    
:-comment(nqueen/2,[
summary:"Run nqueens for size N, return solution in list L",
args:["N":"integer N >=4",
"L":"variable, will be instantiated to a list of integers X, 1=<X=<N"],
amode:nqueen(++,-),
desc:html("Run the nqueens program for a given size N, greater or equal to 4. ")]).

nqueen(N,L):-
    length(L,N),
    L :: 1..N,
    alldifferent(L),
    noattack(L),
    timeout(search(L,0,input_order,indomain,complete,[]),
    	10,
    	timeout_fail(N)).
    	
timeout_fail(N):-
	writeln(N-timeout).
    
noattack([]).
noattack([H|T]):-
    noattack1(H,T,1),
    noattack(T).
    
noattack1(_,[],_).
noattack1(X,[Y|R],N):-
    X #\= Y+N,
    Y #\= X+N,
    N1 is N+1,
    noattack1(X,R,N1).
    