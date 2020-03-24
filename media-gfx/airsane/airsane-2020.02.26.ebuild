# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#Ebuild based on the booboo overlay version

EAPI=7

inherit cmake-utils

# Todo: enable OpenGL (currently not compiling)
#       enable OpenCl, needs check whether OpenCL is actually usable


DESCRIPTION="Apple AirScan compatible SANE web frontend."
HOMEPAGE="https://github.com/SimulPiscator/AirSane"
SRC_URI="https://github.com/awenocur/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86 ~ppc64 ~ppc ~arm ~arm64"
IUSE="imagemagick ffmpeg dv openexr opengl truetype jpeg tiff fontconfig"

DEPEND="
	media-gfx/sane-backends
        net-dns/avahi
	media-libs/libpng"
RDEPEND="${DEPEND}
"

S=${WORKDIR}/AirSane-${PV}

PATCHES=(
	"${FILESDIR}"/png.patch
)

src_configure() {
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
}
