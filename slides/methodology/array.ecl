:-module(array).
:-export(top/0).
:-lib(ic).

top:-
        nqueen(8,Array), writeln(Array).
    
nqueen(N,Array):-
        dim(Array,[N]),
        Array[1..N] :: 1..N,
        alldifferent(Array[1..N]),
        noattack(Array,N),
        labeling(Array[1..N]).

        
noattack(Array,N):-
        (for(I,1,N-1),
         param(Array,N) do
            (for(J,I+1,N),
             param(Array,I) do
                subscript(Array,[I],Xi),
                subscript(Array,[J],Xj),
                D is I-J,
                Xi #\= Xj+D,
                Xj #\= Xi+D
            )
        ).

