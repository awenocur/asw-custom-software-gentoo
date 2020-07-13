# Copyright 1999-2019 Adam Wenocur
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit font

DESCRIPTION="Calibri is a sans-serif typeface household developed by Luc(as) de Groot in 2002-2004 and introduced on the general general public in 2007, with Microsoft Office 2007 and Windows Vista.

In Workplace 2007, it replaced Occasions New Roman since the default typeface in Term and replaced Arial as the default in PowerPoint, Excel, Outlook, and WordPad. De Groot explained its subtly rounded structure as having “a heat and smooth character”."
SRC_URI="calibri-font-sv.zip"

LICENSE="Ascender-Font"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 ~s390 ~sh sparc x86"
SLOT="0"

DEPEND="app-arch/unzip"

FONT_SUFFIX="ttf"
S=${WORKDIR}/'calibri font sv'

src_prepare() {
	    default
	    for item in *.zip; do unzip "$item"; done
}