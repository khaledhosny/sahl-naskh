import fontforge
import sys

filename = sys.argv[1]
f = fontforge.open(filename)
s = f.glyphs()
#f = fontforge.activeFont()
#s = f.selection.byGlyphs

anchors = {}

above_anchors = ("Anchor-0", )
below_anchors = ("Anchor-1", )

dot_bbox = f["onedot.above"].boundingBox()
dot = dot_bbox[2] - dot_bbox[0]

ascent = f.os2_typoascent
descent = f.os2_typodescent

for g in s:
    above = None
    below = None
    for a in g.anchorPoints:
        if a[1] == "base":
            g.unlinkRef()
            # min/max point in the glyph at the place of the nachor
            min_x = g.foreground.yBoundsAtX(a[2] - dot/2, a[2] + dot/2)[0]
            max_x = g.foreground.yBoundsAtX(a[2] - dot/2, a[2] + dot/2)[1]
            old_x = a[3]
            if a[0] in above_anchors:
                if old_x < max_x + dot:
                    above = round(max_x + dot)
                    # no anchors above font's ascent
                    if above > ascent:
                        above = ascent
                    # unless that what we had before
                    if old_x > above:
                        above = None
            elif a[0] in below_anchors:
                if old_x > min_x - dot:
                    below = round(min_x - dot)
                    # no anchors below font's descent
                    if below < descent:
                        below = descent
                    # unless that what we had before
                    if old_x < below:
                        below = None

    anchors[g.glyphname] = (above, below)

f.close()

f = fontforge.open(filename)
s = f.glyphs()

for g in s:
    if g.glyphname in anchors:
        for a in g.anchorPoints:
            if a[1] == "base":
                if a[0] in above_anchors:
                    pos  = anchors[g.glyphname][0]
                    if pos != None:
                        g.addAnchorPoint("old_above", a[1], a[2], a[3])
                        g.addAnchorPoint(a[0], a[1], a[2], pos)
                        if g.color > 0:
                            g.color += 0x00ff00
                        else:
                            g.color = 0x00ff00
                elif a[0] in below_anchors:
                    pos  = anchors[g.glyphname][1]
                    if pos != None:
                        g.addAnchorPoint("old_below", a[1], a[2], a[3])
                        g.addAnchorPoint(a[0], a[1], a[2], pos)
                        if g.color > 0:
                            g.color += 0xff0000
                        else:
                            g.color = 0xff0000

f.save()
#print anchors
