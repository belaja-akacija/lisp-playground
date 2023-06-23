LISP ?= sbcl
ASD := bkmks.asd
ASD_PATH := $(shell pwd)/$(ASD)
BINARY := bkmks

build:
	$(LISP) --eval "(asdf:load-asd #P\"$(ASD_PATH)\")" \
		--eval '(ql:quickload :bkmks)' \
		--eval "(sb-ext:save-lisp-and-die #P\"$(BINARY)\" :toplevel #'main :executable t)" \
		--eval '(quit)'

install:
	install -v bkmks ~/bin/$(BINARY)
