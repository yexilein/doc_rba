
PRODUCT_NAME=xml_format
FIGURES=figures/intro.pdf figures/polymers.pdf figures/processing_map.pdf \
figures/process.pdf figures/combining_processes.pdf figures/targets.pdf \
figures/enzyme.pdf figures/functions.pdf figures/density.pdf \
figures/density_future.pdf figures/solving.pdf figures/ecoli.pdf \
figures/processing_map_2.pdf

$(PRODUCT_NAME).pdf: $(PRODUCT_NAME).tex $(FIGURES)
	pdflatex $(PRODUCT_NAME)
	pdflatex $(PRODUCT_NAME)

%.pdf: %.svg
	./svg2pdf.sh $(CURDIR)/$<
