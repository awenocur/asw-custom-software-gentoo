# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 )

inherit qmake-utils 

DESCRIPTION="GUI for svgcleaner"
HOMEPAGE="https://github.com/RazrFalcon/svgcleaner-gui"
SRC_URI="https://github.com/RazrFalcon/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="amd64 ~x86"
SLOT="0"

COMMON="
	dev-libs/glib:2
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtxml:5
"
RDEPEND="${COMMON}
	media-gfx/svgcleaner
"
DEPEND="${COMMON}
	virtual/pkgconfig
"

src_prepare() {
	default
}

src_configure() {
	eqmake5
}

src_compile() {
	default
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}
