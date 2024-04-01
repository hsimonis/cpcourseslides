:- module(all).

:-export(top/0).

:-lib(ic).
:-lib(timeout).
:-use_module('../reorder').

top:-
%        top(naive),
%        top(first_fail),
        top(middle_min),
        top(middle),
%        top(credit),        
        true.

top(Type):-
        concat_string([Type,"/","all.txt"],File),
        open(File,write,S),
        (for(J,4,100),
         param(S,Type) do
            nqueen(S,Type,J)
        ),
        close(S).

nqueen(S,Type,N):-
        cputime(Start),
        length(L,N),
        L :: 1..N,
        alldifferent(L),
        noattack(L),
        timeout(((Type = naive ->
                     search(L,0,input_order,indomain,complete,[])
                 ; Type = first_fail ->
                     search(L,0,first_fail,indomain,complete,[])
                 ; Type = middle_min ->
                     reorder(L,Reordered),
                     search(Reordered,0,first_fail,indomain,complete,[])
                 ; Type = middle ->
                     reorder(L,Reordered),
                     search(Reordered,0,first_fail,indomain_middle,complete,[])
                 ; Type = credit ->
                     reorder(L,Reordered),
                     search(Reordered,0,first_fail,indomain,credit(N,5),[])
                 ;
                     writeln(wrong_type(Type)),
                     abort
                 ),
                 Time is cputime-Start,
                 printf(S,"%d %w\n",[N,Time]),
                 writeln(N-Time)
                ),
                100,
                writeln(timeout(N))).

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

    