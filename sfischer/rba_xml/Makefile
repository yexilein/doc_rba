
FILENAME=rba_xml

SRC_TEX=$(wildcard *.tex)
FIGURES=$(wildcard figures/*.pdf)

$(FILENAME).pdf: $(SRC_TEX) $(FIGURES)
	pdflatex $(FILENAME)
#	bibtex $(FILENAME)
#	pdflatex $(FILENAME)
	pdflatex $(FILENAME)

%.pdf: %.svg
	./svg2pdf.sh $(PWD)/$<
