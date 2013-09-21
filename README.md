Sahl Naskh font
===============

Sahl (Arabic for even, easy, convenient) is a fork of *Droid Arabic Naskh*
font, fixing some of the issues in the original font.

Changes:
* Quranic annotation marks:
 - Made U+06E4 bigger, it was tiny and almost invisible!
 - Changed U+06E0 to be a small 0, not a black rectangle!
 - Changed U+06DF to be a small sukun, not black circle!
 - Changed U+06E1 to not be a small initial haa!
* Increased the distance between vowel marks and base letter, they were too
  close to be readable.
* Removed the Riyal ligature, this symbol should be used directly if needed,
  not automatically replace the Arabic word riyal.
* Added GDEF ligature caret, just in case any application begins to support
  them.
* Merged the Droid Serif in the font, so that it covers Latin and punctuation
  marks.
* Raised the isolated Noon to the baseline, as it looks out of place next to
  Waw, Raa or even Alef (the glyphs it is likely to come next to).
* Fixed the position of Hamza below Lam-Alef; it was placed under the Lam!
