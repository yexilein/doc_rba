
PRODUCT_NAME=rba_package
FIGURES=figures/intro.pdf figures/package_structure.pdf figures/xml_python_mirror.pdf \
figures/xml_files.pdf figures/xml_mass_conservation.pdf figures/xml_density_constraints.pdf figures/xml_capacity_constraints.pdf \
figures/prerba_summary.pdf figures/rbacore_summary.pdf figures/constraints.pdf figures/example.pdf

$(PRODUCT_NAME).pdf: $(PRODUCT_NAME).tex $(FIGURES)
	pdflatex $(PRODUCT_NAME)
	pdflatex $(PRODUCT_NAME)

%.pdf: %.svg
	./svg2pdf.sh $<
