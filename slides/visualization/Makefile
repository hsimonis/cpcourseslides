all: slides.pdf article.pdf handout.pdf

slides.pdf: slides.tex standalone.tex body.tex
	pdflatex slides
	bibtex slides
	pdflatex slides
	pdflatex slides

article.pdf: article.tex standalone.tex body.tex
	pdflatex article
	bibtex article
	pdflatex article
	pdflatex article

handout.pdf: handout.tex standalone.tex body.tex
	pdflatex handout
	bibtex handout
	pdflatex handout
	pdflatex handout

clean:
	rm -f slides.pdf article.pdf handout.pdf
	rm -f *.aux *.idx *.out *.snm *.tcp *.toc *.vrb *.tps *.log *.nav
