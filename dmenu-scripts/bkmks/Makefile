LISP ?= sbcl

build:
	$(LISP) --eval '(asdf:load-asd #P"/home/belajaakacija/Documents/scripts/lisp/small-projects/dmenu-scripts/bkmks/bkmks.asd")' \
		--eval '(ql:quickload :bkmks)' \
		--eval "(sb-ext:save-lisp-and-die #P\"bkmks\" :toplevel #'main :executable t)" \
		--eval '(quit)'

install:
	install -v bkmks ~/bin/bkmks
