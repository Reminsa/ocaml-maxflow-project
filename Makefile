.PHONY: all build format edit demo clean

src?=0
dst?=5
graph?=graph1.txt

all: build

build:
	@echo "\n   🚨  COMPILING  🚨 \n"
	dune build src/ftest.exe
	ls src/*.exe > /dev/null && ln -fs src/*.exe .


buildbip:
	@echo "\n   🚨  COMPILING  🚨 \n"
	dune build src/bipartest.exe

format:
	ocp-indent --inplace src/*

edit:
	code . -n

demo: build
	@echo "\n   ⚡  EXECUTING  ⚡\n"
	./ftest.exe graphs/${graph} $(src) $(dst) outfile outfiledot graphs/parcoursup_data.txt outfile_biparti outfiledot_biparti
	@echo "\n   🥁  RESULT (content of outfile)  🥁\n"
	@cat outfile
	dot -Tsvg outfiledot > graph.svg
	@echo "\n   🥁  RESULT (content of outfile_biparti)  🥁\n"
	@cat outfile_biparti
	dot -Tsvg outfiledot_biparti > graph_biparti.svg


clean:
	find -L . -name "*~" -delete
	rm -f *.exe
	dune clean
