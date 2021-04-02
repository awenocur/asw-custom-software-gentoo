# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 )

inherit qmake-utils 

DESCRIPTION="GUI for svgcleaner"
HOMEPAGE="https://github.com/RazrFalcon/svgcleaner-gui"
SRC_URI="https://download.clipgrab.org/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="amd64 ~x86"
SLOT="0"

COMMON="
	>=media-video/ffmpeg-4
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwebengine:5
"
RDEPEND="${COMMON}
"
DEPEND="${COMMON}
	virtual/pkgconfig
"

src_prepare() {
	default
}

src_configure() {
	eqmake5 clipgrab.pro
}

src_compile() {
	default
}

src_install() {
	dobin clipgrab
}
