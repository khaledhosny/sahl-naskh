import fontforge
import sys

font = fontforge.open(sys.argv[1])

if len(sys.argv) > 4:
  font.mergeFeature(sys.argv[4])

font.version = sys.argv[3]
# replace the full OFL with shorter text
font.appendSFNTName ("English (US)", "License", "OFL v1.1")
# no need for this on the web either
font.appendSFNTName ("English (US)", "Descriptor", "")
font.generate(sys.argv[2], flags=("round", "opentype", "short-post"))

