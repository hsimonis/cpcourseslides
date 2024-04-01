int: s;
int: n=s*s;
array[1..n,1..n] of var 1..n: puzzle;

include "sudoku.dzn";

predicate alldifferent(array[int] of var int: x) =
  forall(i,j in index_set(x) where i < j)
    (x[i] != x[j]); 
    
constraint forall(i in 1..n)
    (alldifferent([puzzle[i,j]| j in 1..n]));
constraint forall(j in 1..n)
    (alldifferent([ puzzle[i,j]| i in 1..n]));
constraint forall(i,j in 1..s)
    (alldifferent([puzzle[s*(i-1)+p, s*(j-1)+q]|
                  p,q in 1..s]));
solve satisfy;

output [ "sudoku:\\n" ] ++
  [ show(puzzle[i,j]) ++
    if j = n then
       if i mod s = 0 /\ i < n then "\n\n"
       else "\n"
       endif
     else
       if j mod s = 0 then "  "
       else " "
       endif
     endif
    | i,j in 1..n ];
