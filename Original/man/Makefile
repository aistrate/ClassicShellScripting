### ====================================================================

CHKDELIM	= chkdelim

CHKDELIMFLAGS	=

DEROFF		= deroff

# For ghostscript:
PSTOPDF		= ps2pdf
PSTOPDFFLAGS	= -dCompatibilityLevel=1.2 \
		  -dSubsetFonts=true \
		  -dEmbedAllFonts=true \
		  -dMaxSubsetPct=99 \
		  -dPDFSETTINGS=/prepress

## For Acrobat:
PSTOPDF		= distill
PSTOPDFFLAGS	= -subsetfonts on \
		  -embedallfonts on \
		  -maxsubsetpct 99 \
		  -colordownsample off \
		  -graydownsample off \
		  -monodownsample off

DW		= dw

ISPELL		= env LANG=C ispell

LS		= ls

MAKEINFO	= makeinfo

MAN2HTML	= man2html

MAN2PS		= man2ps

MAN2TEXI	= man2texi

MYSPELL		= env LANG=C myspell

RM		= /bin/rm -f

SHELL		= /bin/sh

SORT		= sort

SPELL		= env LANG=C spell

TEST		= test

TOUCH		= touch

### pathfind.man suppressed for now because the PostScript version needs
### special processing (see the README file)
MANFILES	= build-all.man pathfind.man myspell.man
MANFILES	= build-all.man myspell.man

DELIMFILES	= $(MANFILES:.man=.delim)
DWFILES		= $(MANFILES:.man=.dw)
HTMLFILES	= $(MANFILES:.man=.html)
INFOFILES	= $(MANFILES:.man=.info)
PDFFILES	= $(MANFILES:.man=.pdf)
PSFILES		= $(MANFILES:.man=.ps)
SERFILES	= $(MANFILES:.man=.ser)
TEXIFILES	= $(MANFILES:.man=.texi)

### ====================================================================

.SUFFIXES:
.SUFFIXES:	.delim .dw .info .ser .html .man .pdf .ps .texi

### Delimiter balance checks...
.man.delim:
	-@$(CHKDELIM) $(CHKDELIMFLAGS) $< 2>&1 >$@
	-@$(TEST) -s $@ && $(LS) -l $@

### Doubled words...
.man.dw:
	-@$(DEROFF) < $< | $(DW) > $@
	-@$(TEST) -s $@ && $(LS) -l $@

.man.html:
	$(MAN2HTML) $<

.man.ps:
	$(MAN2PS) $< > $@

.man.ser:
	-@$(TEST) -f $*.sok || $(TOUCH) $*.sok
	$(DEROFF) < $< | $(ISPELL) -l -p $*.sok > $@.tmp	2> /dev/null
	$(DEROFF) < $< | $(MYSPELL) +$*.sok >> $@.tmp
	$(DEROFF) < $< | $(SPELL) +$*.sok >> $@.tmp
	@$(SORT) -u $@.tmp > $@ && $(RM) $@.tmp
	@$(LS) -l $@
	@-$(TEST) -s $@ && echo Exception count = `wc -l < $@`

.man.texi:
	$(MAN2TEXI) $< > $@

.ps.pdf:
	$(PSTOPDF) $(PSTOPDFFLAGS) $<

.texi.info:
	$(MAKEINFO) $<

### ====================================================================

all:	html-files ps-files pdf-files texi-files info-files

chkdelim:	$(DELIMFILES)

clean:
	-$(RM) *.i
	-$(RM) *.o
	-$(RM) *~
	-$(RM) \#*
	-$(RM) a.out
	-$(RM) core

clobber:	distclean

distclean:	mostlyclean

dw:	$(DWFILES)

html-files:	$(HTMLFILES)

info-files:	$(INFOFILES)

maintainer-clean:	distclean
	@echo "This command is intended for maintainers to use;"
	@echo "it deletes files that may require special tools to rebuild."

mostlyclean:	clean

pdf-files:	$(PDFFILES)

ps-files:	$(PSFILES)

ser-files:	$(SERFILES)

spell:		ser-files

texi-files:	$(TEXIFILES)
