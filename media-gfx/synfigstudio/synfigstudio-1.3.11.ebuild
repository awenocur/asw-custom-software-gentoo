# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit cmake-utils eutils fdo-mime

DESCRIPTION="Main UI of synfig: Film-Quality Vector Animation"
HOMEPAGE="http://www.synfig.org/"
SRC_URI="https://github.com/synfig/synfig/archive/v${PV}.tar.gz -> synfig-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	dev-cpp/gtkmm:3.0
	>=media-gfx/synfig-${PV}
	dev-libs/libsigc++:2"
RDEPEND=${DEPEND}

S=${WORKDIR}/synfig-${PV}/synfig-studio

src_prepare() {
	sed -i "/DESTINATION/s/lib/$(get_libdir)/" src/synfigapp/CMakeLists.txt
	eapply_user
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_BUILD_TYPE=Release
	)
	cmake-utils_src_configure
	#econf --disable-update-mimedb
}

src_compile() {
	cmake-utils_src_compile build_images all
	#cmake-utils_src_compile all
}

src_install() {
	cmake-utils_src_install

	doicon ${BUILD_DIR}/images/synfig_icon.png
	#domenu synfigstudio.desktop
}

pkg_postinst() {
	fdo-mime_mime_database_update
}

pkg_postrm() {
	fdo-mime_mime_database_update
}
