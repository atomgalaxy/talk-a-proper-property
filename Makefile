
NULL:=
CXX=/Users/atomicity/llvm/llvm-lto-install/bin/clang++
CXXFLAGS=\
				 -std=c++17 \
				 -pedantic \
				 -fsanitize=undefined \
				 -fsanitize=address \
				 -stdlib=libc++ \
#				 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.13.sdk \
				 $(NULL)

INKSCAPE=/Applications/Inkscape.app/Contents/Resources/bin/inkscape

.PHONY: all
all:

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
	$(INKSCAPE) "$(PWD)/$<" -A="$(PWD)/$@" --without-gui

all: check-std-exchange
check-std-exchange: check-std-exchange.cpp
	$(CXX) -o $@ $< $(CXXFLAGS)

all: check-member-ptr-contents
check-member-ptr-contents: check-member-ptr-contents.cpp
	$(CXX) -o $@ $< $(CXXFLAGS)

all: offset_of
offset_of: offset_of.cpp
	$(CXX) -o $@ $< $(CXXFLAGS)
