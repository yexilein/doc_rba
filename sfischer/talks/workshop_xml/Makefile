
PRODUCT_NAME=xml_format
FIGURES=

$(PRODUCT_NAME).pdf: $(PRODUCT_NAME).tex $(FIGURES)
	pdflatex $(PRODUCT_NAME)
	pdflatex $(PRODUCT_NAME)

%.pdf: %.svg
	./svg2pdf.sh $<
