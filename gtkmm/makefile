all: main.pdf
main.pdf:main.typ
	typst compile main.typ
display:
	evince main.pdf
clean:
	rm -f main.pdf

