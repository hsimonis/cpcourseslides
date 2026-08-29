include "globals.mzn";

% Integer Parameters
int:size; % problem:size

% Variables
array[1..size*size,1..size*size] of var 1..size*size:x; % array

% Constraint 1
constraint forall(i in 1..size*size)
	(all_different([x[i,j]|j in 1..size*size]));
% Constraint 2
constraint forall(j in 1..size*size)
	(all_different([x[i,j]|i in 1..size*size]));
% Constraint 3
constraint forall(i, j in 1..size)
	(all_different([x[(i-1)*size+i1,(j-1)*size+j1]|i1, j1 in 1..size]));

% Objective
solve satisfy;

