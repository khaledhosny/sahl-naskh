from sortsmill import ffcompat as fontforge
import sys

font = fontforge.open(sys.argv[1])

if len(sys.argv) > 4:
  font.mergeFeature(sys.argv[4])

font.version = sys.argv[3]
# no need for this on the web, saves few KBs
font.appendSFNTName ("English (US)", "Descriptor", "")
font.generate(sys.argv[2], flags=("round", "opentype", "short-post"))

