
NULL:=

.PHONY: all
all: a-proper-property.pdf

a-proper-property.pdf: .a-proper-property-tmp.pdf
	cp $< $@

.a-proper-property-tmp.pdf: \
	a-proper-property.tex \
	CargoCultAirplane.jpg \
	$(NULL)
	pdflatex -jobname $(patsubst %.pdf,%,$@) $<
	pdflatex -jobname $(patsubst %.pdf,%,$@) $<
