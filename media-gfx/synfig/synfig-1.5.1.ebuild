# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

#Ebuild based on the booboo overlay version

EAPI=8

inherit autotools multilib flag-o-matic

# Original TODO from bgo-overlay
# Todo: enable OpenGL (currently not compiling)
#       enable OpenCl, needs check whether OpenCL is actually usable

DESCRIPTION="Film-Quality Vector Animation (core engine)"
HOMEPAGE="http://www.synfig.org/"
SRC_URI="https://github.com/synfig/synfig/releases/download/v${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="imagemagick ffmpeg dv openexr truetype jpeg fontconfig opencl"

DEPEND="
	~dev-cpp/ETL-${PV}
	>=dev-cpp/glibmm-2.4:2
	dev-cpp/libxmlpp:2.6
	dev-libs/boost:=
	dev-libs/libsigc++:2
	media-libs/libpng:=
	media-libs/mlt:=
	sci-libs/fftw:3.0
	sys-libs/zlib:=
	x11-libs/cairo:=
	x11-libs/pango:=
	ffmpeg? ( media-video/ffmpeg:= )
	fontconfig? ( media-libs/fontconfig )
	jpeg? ( virtual/jpeg )
	opencl? ( dev-libs/opencl-icd-loader )
	openexr? ( media-libs/openexr:= )
	truetype? ( media-libs/freetype:= )
	"
RDEPEND="${DEPEND}
	dv? ( media-libs/libdv:= )
	imagemagick? ( media-gfx/imagemagick:= )
	"

PATCHES=(
	"${FILESDIR}"/${PN}-1.4.0-fix-cflags.patch
	"${FILESDIR}"/skip-ocl-check.patch
)

src_prepare() {
	default

	eautoreconf
}

src_configure() {
	econf \
		$(use_with ffmpeg) \
		$(use_with fontconfig) \
		$(use_with imagemagick) \
		$(use_with dv libdv) \
		$(use_with openexr ) \
		$(use_with truetype freetype) \
		$(use_with jpeg) \
		$(use_with opencl)
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS NEWS README TODO

	echo "LDPATH=\"/usr/lib64/synfig/modules\"" > "${T}/99synfig"
	doenvd "${T}/99synfig"
}
