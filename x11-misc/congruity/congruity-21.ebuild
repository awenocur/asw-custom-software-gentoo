# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 python3_6 python3_7 python3_8 python3_9 )

inherit distutils-r1

#mydistutilsargs='--skip-update-desktop-db'

DESCRIPTION="GUI application for programming Logitech Harmony remote controls"
HOMEPAGE="https://sourceforge.net/projects/congruity/"
SRC_URI="mirror://sourceforge/${PN}/${PV}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=">=dev-python/wxpython-4.0
		dev-libs/libconcord[python]
"
RDEPEND="${DEPEND}"


python_prepare_all() {
	distutils-r1_python_prepare_all
}

python_compile_all() {
	distutils-r1_python_compile
}

python_install() {
	distutils-r1_python_install --skip-update-desktop-db
}

python_install_all() {
	distutils-r1_python_install_all --skip-update-desktop-db
}
