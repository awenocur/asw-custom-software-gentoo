# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#Ebuild based on the booboo overlay version

EAPI=6

inherit cmake-utils

# Todo: enable OpenGL (currently not compiling)
#       enable OpenCl, needs check whether OpenCL is actually usable


DESCRIPTION="Film-Quality Vector Animation (core engine)"
HOMEPAGE="http://www.synfig.org/"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="imagemagick ffmpeg dv openexr opengl truetype jpeg tiff fontconfig"

DEPEND="
	=dev-cpp/ETL-${PV}
	dev-libs/boost
	sys-libs/zlib
	dev-libs/libsigc++:2
	dev-cpp/libxmlpp:2.6"
#	media-libs/libpng
#	media-libs/mlt
#	x11-libs/pango
#	sci-libs/fftw
#	ffmpeg? ( virtual/ffmpeg )
#	openexr? ( media-libs/openexr )
#	truetype? ( media-libs/freetype )
#	fontconfig? ( media-libs/fontconfig )
#	jpeg? ( virtual/jpeg )
#	tiff? ( media-libs/tiff )"
RDEPEND="${DEPEND}"
#	dv? ( media-libs/libdv )
#	imagemagick? ( media-gfx/imagemagick )"

S=${WORKDIR}/${P}/synfig-core

src_prepare() {
	sed -i "s:lib/:$(get_libdir)/:" src/modules/*/CMakeLists.txt
	sed -i 's:DESTINATION etc:DESTINATION ../etc:' src/modules/CMakeLists.txt
	sed -i "/LIBRARY DESTINATION/s/lib/$(get_libdir)/" src/synfig/CMakeLists.txt
	sed -i '341s:(.*):("/etc/" MODULE_LIST_FILENAME):' src/synfig/main.cpp
	eapply_user
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE=Release
	)
	cmake-utils_src_configure
	#$(use_with ffmpeg) \
	#$(use_with fontconfig) \
	#$(use_with imagemagick) \
	#$(use_with dv libdv) \
	#$(use_with openexr ) \
	#$(use_with opengl ) \
	#$(use_with truetype freetype) \
	#$(use_with jpeg)
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
}
