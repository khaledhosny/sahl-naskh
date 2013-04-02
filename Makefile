NAME=sahl-naskh
SHORTNAME=$(subst -,,$(NAME))
VERSION=1.001

SRC=sources
DOC=documentation
DOCSRC=$(DOC)/$(DOC)-$(SRC)
DIST=$(NAME)-$(VERSION)

PY=python

define $(SHORTNAME)SCRIPT
import fontforge, sys
f = fontforge.open(sys.argv[1])
if len(sys.argv) > 3:
  f.mergeFeature(sys.argv[3])
f.version = "$(VERSION)"
f.generate(sys.argv[2], flags=("round", "opentype"))
endef

export $(SHORTNAME)SCRIPT

FONTS=regular bold

SFD=$(FONTS:%=$(SRC)/$(SHORTNAME)-%.sfdir)
TTF=$(FONTS:%=$(SHORTNAME)-%.ttf)

all: ttf

ttf: $(TTF)

%.ttf: $(SRC)/%.sfdir Makefile
	@echo "Building $@"
	@$(PY) -c "$$$(SHORTNAME)SCRIPT" $< $@

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
