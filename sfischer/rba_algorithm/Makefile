
FILENAME=rba_algorithm

SRC_TEX=rbav01.tex rewriting.tex mu_dependency.tex new_formalism.tex

FIGURES=figures/RBA.pdf figures/matrices_RBA.pdf figures/algo_RBA.pdf figures/new_matrices_RBA.pdf figures/new_matrices_RBA_mu.pdf figures/algo_RBA_new.pdf figures/composition_matrices.pdf figures/process_matrices.pdf figures/optimization_matrices.pdf figures/metabolism.pdf figures/parameters.pdf figures/proteins.pdf figures/rnadna.pdf figures/processes.pdf

$(FILENAME).pdf: $(FILENAME).tex $(FILENAME).bib $(SRC_TEX) $(FIGURES)
	pdflatex $(FILENAME)
#	bibtex $(FILENAME)
#	pdflatex $(FILENAME)
	pdflatex $(FILENAME)

%.pdf: %.svg
	./svg2pdf.sh $<
