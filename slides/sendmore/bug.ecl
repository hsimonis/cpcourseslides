:- module(bug).
:-export(sendmory/1).
:-lib(ic).

	
sendmory(L):-
	L=[S,E,N,D,M,O,R,Y],
	L :: 0..9,
	alldifferent(L),
	S #\= 0,
	M #\= 0,
	
	1000*S+100*E+10*N+D + 
	1000*M+100*O+10*R+E #= 
	10000*M + 1000*O+100*N+10*E+Y,
        writeln(L),
	label(L,['S','E','N','D','M','O','R','Y']).

label([],[]):-
        writeln('SUCC').
label([H|T],[A|A1]):-
        (integer(H) ->
            writeln(fixed(A,H))
        ;
            get_domain_as_list(H,L),
            try_value(A,H,L)
        ),
        label(T,A1).

try_value(A,X,[H|_]):-
        writeln(try(A,H)),
        X = H,
        writeln(ok).
try_value(A,X,[_|T]):-
        try_value(A,X,T).
        
	