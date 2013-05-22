import fontforge
import sys

font = fontforge.open(sys.argv[1])

if len(sys.argv) > 3:
  font.mergeFeature(sys.argv[3])

font.version = "$(VERSION)"
font.generate(sys.argv[2], flags=("round", "opentype"))

