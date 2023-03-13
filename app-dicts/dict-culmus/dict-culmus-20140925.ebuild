# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

MY_P=${P/td/t}-pre
DESCRIPTION="Culmus Hebrew-English Dictionary, derived from Wiktionary"
HOMEPAGE="https://doqrgprtbhv2e2kjxclnnvdbjy--sourceforge-net.translate.goog/projects/culmus/files/language_tools/dictionary/20140925/"
SRC_URI="dict-culmus-20140925.tgz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
KEYWORDS="amd64 ppc ppc64 sparc x86"

DEPEND=">=app-text/dictd-1.5.5"

S=${WORKDIR}

src_install() {
	insinto /usr/lib/dict
	doins wordnet-he-eng.dict.dz wordnet-he-eng.index || die
}
