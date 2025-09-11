To create the slides, you need to have the ubuntu.sty and related fonts installed. This can be downloaded from

 https://github.com/tzwenn/ubuntu-latex-fonts/archive/master.zip
 
 Unpack and run
 
 make PREFIX=/cygdrive/c/texlive/texmf-local installed
 
 in the unpacked directory.
 
 To make the slides, run
 
 make clean
 make all
 
 this should produce files in all directories for the course. The main lectures are
 
 1) introduction
 2) minizinc
 methodology
 applications
 visualization
 
 The introduction combines the slides from sendmore sudoku and nqueens into a single lecture. 
 The order of the methodology, applications, and visualization lectures is not predetermined.