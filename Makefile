DIR = _build
INPUT = master
OUTPUT = book
DIAGRAM = --require=asciidoctor-diagram
MATH = --require=asciidoctor-mathematical
# REQUIRES = ${DIAGRAM} ${MATH}
REQUIRES =
OUTPUT_FOLDER = --destination-dir=${DIR}
HTML = --backend=html5 -a max-width=55em
PDF =  --backend=pdf --require=asciidoctor-pdf
EPUB = --backend=epub3 --require=asciidoctor-epub3

# Public targets

all: clean html pdf

html: _build/html_book.html

pdf: _build/pdf_book.pdf

compressed_pdf: _build/compressed_pdf_book.pdf

epub: _build/epub_book.epub

stats:
	wc -w chapters/*.adoc

clean:
	if [ -d ".asciidoctor" ]; \
		then rm -r .asciidoctor; \
	fi; \
	if [ -d "${DIR}" ]; \
		then rm -r ${DIR}; \
	fi; \

# Private targets

_build/html_book.html:
	asciidoctor ${HTML} ${REQUIRES} ${OUTPUT_FOLDER} --out-file=html_${OUTPUT}.html ${INPUT}.adoc; \

_build/pdf_book.pdf:
	asciidoctor ${PDF} ${REQUIRES} ${OUTPUT_FOLDER} --out-file=pdf_${OUTPUT}.pdf ${INPUT}.adoc; \

# Courtesy of
# http://www.smartjava.org/content/compress-pdf-mac-using-command-line-free
# Requires `brew install ghostscript`
_build/compressed_pdf_book.pdf: _build/pdf_book.pdf
	gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/ebook -dNOPAUSE -dQUIET -dBATCH -sOutputFile=${DIR}/compressed_pdf_book.pdf ${DIR}/pdf_book.pdf; \

_build/epub_book.epub:
	asciidoctor ${EPUB} ${REQUIRES} ${OUTPUT_FOLDER} --out-file=epub_${OUTPUT}.epub ${INPUT}.adoc; \
