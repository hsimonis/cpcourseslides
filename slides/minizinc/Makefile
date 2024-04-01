all: slides.pdf article.pdf handout.pdf

slides.pdf: slides.tex standalone.tex body.tex
	pdflatex slides
	pdflatex slides

article.pdf: article.tex standalone.tex body.tex
	pdflatex article
	pdflatex article

handout.pdf: handout.tex standalone.tex body.tex
	pdflatex handout
	pdflatex handout

clean:
	rm slides.pdf article.pdf handout.pdf