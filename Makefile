NAME=sahl-naskh
SHORTNAME=$(subst -,,$(NAME))
VERSION=1.001

TOOLS=tools
SRC=sources
WEB=webfonts
DOC=documentation
DOCSRC=$(DOC)/$(DOC)-$(SRC)
DIST=$(NAME)-$(VERSION)

PY=python
BUILD=$(TOOLS)/build.py
BUILDWEB=$(TOOLS)/build-web.py
SFNTTOOL=sfnttool

FONTS=regular bold

SFD=$(FONTS:%=$(SRC)/$(SHORTNAME)-%.sfdir)
TTF=$(FONTS:%=$(SHORTNAME)-%.ttf)
WTTF=$(FONTS:%=$(WEB)/$(SHORTNAME)-%.ttf)
WOFF=$(FONTS:%=$(WEB)/$(SHORTNAME)-%.woff)
EOTS=$(FONTS:%=$(WEB)/$(SHORTNAME)-%.eot)

all: ttf web

ttf: $(TTF)
web: $(WTTF) $(WOFF) $(EOTS) $(CSSS)

%.ttf: $(SRC)/%.sfdir Makefile $(BUILD)
	@echo "Building\t$@"
	@$(PY) $(BUILD) $< $@ $(VERSION)

$(WEB)/%.ttf: $(SRC)/%.sfdir Makefile $(BUILDWEB)
	@echo "Building\t$@"
	@mkdir -p $(WEB)
	@$(PY) $(BUILDWEB) $< $@ $(VERSION)

$(WEB)/%.woff: $(WEB)/%.ttf
	@echo "Building\t$@"
	@mkdir -p $(WEB)
	@$(SFNTTOOL) -w $< $@

$(WEB)/%.eot: $(WEB)/%.ttf
	@echo "Building\t$@"
	@mkdir -p $(WEB)
	@$(SFNTTOOL) -e -x $< $@

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
