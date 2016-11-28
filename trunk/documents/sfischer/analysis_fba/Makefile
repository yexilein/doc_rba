
FILENAME=analysis_fba
SRC_TEX=
FIGURES=figures/2D_duality.pdf figures/2D_duality_inequalities.pdf

$(FILENAME).pdf: $(FILENAME).tex $(FILENAME).bib $(SRC_TEX) $(FIGURES)
	pdflatex $(FILENAME)
#	bibtex $(FILENAME)
#	pdflatex $(FILENAME)
	pdflatex $(FILENAME)

%.pdf: %.svg
	./svg2pdf.sh $<
