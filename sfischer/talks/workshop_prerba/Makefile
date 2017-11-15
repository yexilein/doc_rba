
PRODUCT_NAME=prerba
FIGURES=figures/intro.pdf figures/package_structure.pdf \
figures/pipeline_idea.pdf figures/prerba_summary_2.pdf figures/multi_step.pdf

$(PRODUCT_NAME).pdf: $(PRODUCT_NAME).tex $(FIGURES)
	pdflatex $(PRODUCT_NAME)
	pdflatex $(PRODUCT_NAME)

%.pdf: %.svg
	./svg2pdf.sh $<
