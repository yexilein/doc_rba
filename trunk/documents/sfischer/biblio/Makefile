
FILENAME=biblio
SRC_TEX=rba.tex fba.tex
FIGURES=figures/RBA.pdf

$(FILENAME).pdf: $(FILENAME).tex $(FILENAME).bib $(SRC_TEX) $(FIGURES)
	pdflatex $(FILENAME)
	bibtex $(FILENAME)
	pdflatex $(FILENAME)
	pdflatex $(FILENAME)

%.pdf: %.svg
	./svg2pdf.sh $<
