
FILENAME=pipeline

SRC_TEX=pipeline.tex prerba.tex

FIGURES=figures/workflow.pdf

$(FILENAME).pdf: $(FILENAME).tex $(FILENAME).bib $(SRC_TEX) $(FIGURES)
	pdflatex $(FILENAME)
#	bibtex $(FILENAME)
#	pdflatex $(FILENAME)
	pdflatex $(FILENAME)

%.pdf: %.svg
	./svg2pdf.sh $<
