LISP ?= sbcl
ASD := auto-wall.asd
ASD_PATH := $(shell pwd)/$(ASD)
BINARY := auto-wallpaper-changer
INSTALL_PATH := ~/.local/bin

load:
	rlwrap -c $(LISP) --eval "(asdf:load-asd #P\"$(ASD_PATH)\")" \
		--eval '(ql:quickload :auto-wall)' \

build:
	$(LISP) --eval "(asdf:load-asd #P\"$(ASD_PATH)\")" \
		--eval '(ql:quickload :auto-wall)' \
		--eval "(sb-ext:save-lisp-and-die #P\"$(BINARY)\" :toplevel #'wallpaper-changer :executable t :compression t)" \
		--eval '(quit)'

install:
	install -v $(BINARY) $(INSTALL_PATH)/$(BINARY)

clean:
	rm -v $(BINARY)

uninstall:
	rm -v $(INSTALL_PATH)/$(BINARY)
