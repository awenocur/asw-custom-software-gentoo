# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit cmake-utils

DESCRIPTION="Minimalistic protocol buffer decoder and encoder in C++."
HOMEPAGE="https://github.com/mapbox/protozero"
SRC_URI="https://github.com/mapbox/${PN}/archive/v${PV}.zip -> ${P}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"

IUSE=""

RDEPEND="
"
DEPEND="${RDEPEND}
"

src_test() {
    cmake-utils_src_test
}

