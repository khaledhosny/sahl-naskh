import fontforge
import sys

font = fontforge.open(sys.argv[1])

if len(sys.argv) > 3:
  font.mergeFeature(sys.argv[3])

font.version = "$(VERSION)"
# replace the full OFL with shorter text
font.appendSFNTName ("English (US)", "License", "OFL v1.1")
# no need for this on the wen either
font.appendSFNTName ("English (US)", "Descriptor", "")
font.generate(sys.argv[2], flags=("round", "opentype", "short-post"))

