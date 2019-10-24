GEM := gem
RAKE := rake

MODULE := hi
VERSION := $(shell grep VERSION lib/hi/version.rb | cut -d\" -f2)
GEMFILE := $(MODULE)-$(VERSION).gem
FILES := $(shell find lib/ -type f -name '*.rb') $(shell find exe/ -type f)

build: $(GEMFILE)

$(GEMFILE): $(MODULE).gemspec $(FILES)
	$(GEM) build $<

install: $(GEMFILE)
	$(GEM) install $<

.PHONY: test
test:
	$(RAKE) test
