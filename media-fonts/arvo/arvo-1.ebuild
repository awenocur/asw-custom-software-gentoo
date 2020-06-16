# Copyright 1999-2019 Adam Wenocur
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit font

DESCRIPTION="Arvo Font"
SRC_URI="${PN}.zip"

LICENSE="OFL-1.1"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 ~s390 ~sh sparc x86"
SLOT="0"

DEPEND="app-arch/unzip"

FONT_SUFFIX="ttf"
S=${WORKDIR}
