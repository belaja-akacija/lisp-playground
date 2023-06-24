LISP ?= sbcl
ASD := net-lib
ASD_PATH := $(shell pwd)/$(ASD).asd
BINARY := netchk
INSTALL_PATH := ~/.local/bin

build:
	$(LISP) --eval "(asdf:load-asd #P\"$(ASD_PATH)\")" \
		--eval '(ql:quickload :$(ASD))' \
		--eval "(sb-ext:save-lisp-and-die #P\"$(BINARY)\" :toplevel #'main :executable t)" \
		--eval '(quit)'

install:
	install -v $(BINARY) $(INSTALL_PATH)/$(BINARY)

clean:
	rm -v $(BINARY)

uninstall:
	rm -v $(INSTALL_PATH)/$(BINARY)
