
NULL:=

.PHONY: all
all: a-proper-property.pdf

a-proper-property.pdf: .a-proper-property-tmp.pdf
	cp $< $@

.a-proper-property-tmp.pdf: \
	a-proper-property.tex \
	CargoCultAirplane.jpg \
	offsets.pdf \
	$(NULL)
	pdflatex -jobname $(patsubst %.pdf,%,$@) $<
	pdflatex -jobname $(patsubst %.pdf,%,$@) $<

offsets.pdf: ./offset.svg
	/Applications/Inkscape.app/Contents/Resources/bin/inkscape \
		"$(PWD)/$<" -A="$(PWD)/$@" --without-gui
