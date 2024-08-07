:- module(sendmory2).
:-export(sendmory/2).
:-export(top/0).

:-lib(ic).

top:-
        open('log2.txt',write,Stream),
%        sendmory(Stream,L),
        (
            sendmory(Stream,_L),
            fail
        ;
            true
        ),
        close(Stream).

sendmory(Stream,L):-
	L=[S,E,N,D,M,O,R,Y],
	L :: 0..9,
%        [C2,C3,C4,C5] :: 0..1,
	alldifferent(L),
%	S #\= 0,
%	M #\= 0,
	
	1000*S+100*E+10*N+D + 
	1000*M+100*O+10*R+E #= 
	10000*M + 1000*O+100*N+10*E+Y,
/*
        M #= C5,
        S+M+C4 #= 10*C5+O,
        E+O+C3 #= 10*C4+N,
        N+R+C2 #= 10*C3+E,
        D+E    #= 10*C2+Y,
*/
        label(L,['S','E','N','D','M','O','R','Y'],Stream).

label(L,Vars,Stream):-
        node_reset(Nr),
        label(Stream,L,Vars,Nr,-,-).

label(Stream,[],[],Parent,Value,State):-
        node_number(Nr),
        printf(Stream,"SUCCESS %d %d %w %w\n",[Nr,Parent,Value,State]).
label(Stream,[H|T],[A|A1],Parent,Value,State):-
        (integer(H) ->
            Nr = Parent,
            Value1 = Value,
            State1 = State,
%            State1 = f,
%            printf(Stream,"FIXED %d %w %d\n",[Nr,A,H]),
            true
        ;
            node_number(Nr),
            printf(Stream,"TRY %d %d %w %w %w\n",[Nr,Parent,A,Value,State]),
            State1 = v,
            get_domain_as_list(H,L),
            try_value(Stream,A,H,L,Nr,State1),
            Value1 = H
        ),
        label(Stream,T,A1,Nr,Value1,State1).

:-local variable(nr).

node_reset(0):-
        setval(nr,0).

node_number(Nr):-
        incval(nr),
        getval(nr,Nr).

try_value(Stream,A,X,[H|_],Nr,State):-
        ((X = H,true) ->
%            printf(Stream,"OK %d %w %d\n",[Nr,A,H]),
            true
        ;
            node_number(Next),
            printf(Stream,"FAIL %d %d %w %d %w\n",[Next,Nr,A,H,State]),
            fail
        ).
try_value(Stream,A,X,[_|T],Nr,State):-
        try_value(Stream,A,X,T,Nr,State).
        