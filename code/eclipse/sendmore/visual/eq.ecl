:-module(eq).

:-export(top/0).

:-lib(ic).

top:-
        [E,N,D,R,Y] :: 2..8,
        
%        visual(91*E+10*R+D #= 90*N+Y,'step1.pdf').
        E #>= 4,
        E #=< 7,
        N #>= 5, 
        visual(91*E+10*R+D #= 90*N+Y,'step2.pdf').
%        E #= 5,
%        visual(91*E+10*R+D #= 90*N+Y,'assign1.pdf').
%        visual(1000*S+91*E+10*R+D #= 9000*M+900*O+90*N+Y).

visual(TermL #= TermR,Name):-
        term_to_list(TermL,[],ListL),
        sort(1,>=,ListL,SortedL),
        length(ListL,NL),
        term_to_list(TermR,[],ListR),
        sort(1,>=,ListR,SortedR),
        length(ListR,NR),
        Inc is fix(1000/(NL+NR)),
        MinusInc is -Inc,
        writeln(Inc-MinusInc),
        N1 is NL*Inc,
        N is (NL+NR)*Inc,
        begin('C:/Documents and Settings/hsimonis/My Documents/Processing/test/test.dat',S,Name,N1),
        writeln(SortedL),
        place(SortedL,0,0,Inc,S,['E','R','D']),
        place(SortedR,N,0,MinusInc,S,['N','Y']),
        end(S).

place([],_,_,_,_,_).
place([mult(C,L)|R],X,Y,Inc,S,[Name|Names]):-
        Xn is X+Inc//2,
        Yn = 10,
        text(S,Name,Xn,Yn),
        (foreach(V,L),
         param(X,Y,C,R,Inc,S,Names) do
            X1 is X+Inc,
            Y1 is Y+C*V,
            line(S,X,Y,X1,Y1),
            place(R,X1,Y1,Inc,S,Names)
        ).

begin(File,S,Name,N1):-
        open(File,write,S),
        printf(S,"%w\n",[Name]),
        printf(S,"%d\n",[N1]).


end(S):-
        close(S).

line(S,X,Y,X1,Y1):-
        printf(S,"0 %d %d %d %d\n",[X,Y,X1,Y1]).

text(S,Name,X,Y):-
        printf(S,"1 %w %d %d\n",[Name,X,Y]).

term_to_list(X,List,[mult(1,L)|List]):-
        var(X),
        writeln(X),
        !,
        get_domain_as_list(X,L).
term_to_list(X,List,[mult(1,[X])|List]):-
        integer(X),
        !.
term_to_list(C*X,List,[mult(C,L)|List]):-
        var(X),
        !,
        writeln(X),
        get_domain_as_list(X,L).
term_to_list(C*X,List,[mult(C,[X])|List]):-
        integer(X),
        !.
term_to_list(X+Y,L,List):-
        term_to_list(X,L,L1),
        term_to_list(Y,L1,List).
