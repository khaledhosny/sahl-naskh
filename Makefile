NAME=sahl-naskh
SHORTNAME=$(subst -,,$(NAME))
VERSION=1.001

SRC=sources
DOC=documentation
DOCSRC=$(DOC)/$(DOC)-$(SRC)
DIST=$(NAME)-$(VERSION)

PY=python
BUILD=tools/build.py

FONTS=regular bold

SFD=$(FONTS:%=$(SRC)/$(SHORTNAME)-%.sfdir)
TTF=$(FONTS:%=$(SHORTNAME)-%.ttf)

all: ttf

ttf: $(TTF)

%.ttf: $(SRC)/%.sfdir Makefile
	@echo "Building $@"
	@$(PY) $(BUILD) $< $@

dist: $(TTF)
	@echo "Making dist tarball"
	@mkdir -p $(DIST)/$(SRC)
	@mkdir -p $(DIST)/$(DOC)
	@mkdir -p $(DIST)/$(DOCSRC)
	@cp $(SFD) $(DIST)/$(SRC)
	@cp $(TTF) $(DIST)
	@cp -r Makefile OFL-FAQ.txt OFL.txt $(DIST)
	@cp README.md $(DIST)/README.txt
	@zip -r $(DIST).zip $(DIST)

clean:
	@rm -rf $(TTF) $(DIST) $(DIST).zip
