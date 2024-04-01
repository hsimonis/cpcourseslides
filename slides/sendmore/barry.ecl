:-module(barry).

:-export(top/0).

:-lib(ic).


top:-
        [A,B,C] :: 1..36,
        A #>= B, B #>= C,
        A *  B * C #= 36,
        [D,E,F] :: 1..36,
        D #>= E, E #>= F,
        D*E*F #= 36,
        A+B+C #= D+E+F,
        [A,B,C] ~= [D,E,F],
        A #> B,
        labeling([A,B,C,D,E,F]),
        writeln([A,B,C,D,E,F]).

