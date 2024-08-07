:- module(top).

:-export(top/0).

:-lib(ic).

top:-
        nqueen(M,L),
        writeln(L).
    
nqueen(N,L):-
        length(L,N),
        L :: 1..N,
        alldifferent(L),
        noattack(L),
        labeling(L).
        

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

    