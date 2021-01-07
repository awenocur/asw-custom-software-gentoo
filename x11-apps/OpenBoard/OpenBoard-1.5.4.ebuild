# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit qmake-utils eutils xdg

DESCRIPTION="open cross-platform interactive whiteBoard application mainly for use in schools"

HOMEPAGE="http://openboard.ch/"
LICENSE="GPL-3"
SLOT="0"

SRC_URI="
	https://github.com/${PN}-org/${PN}/archive/master.zip -> ${P}.zip
	https://github.com/${PN}-org/${PN}-ThirdParty/archive/master.zip -> ${PN}-ThirdParty-${PV}.zip
"
#SRC_URI="
#	https://github.com/cloc3/OpenBoard/raw/master/distfiles/OpenBoard-1.3.6.zip
#	https://github.com/cloc3/OpenBoard/raw/master/distfiles/OpenBoard-ThirdParty-1.3.6.zip
#"

KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND="
	app-arch/unzip
	media-libs/freetype
	dev-libs/openssl:0
	sys-libs/zlib
	dev-qt/qtlockedfile
	dev-qt/qtsingleapplication
	dev-qt/qtwebkit
"

RDEPEND="${DEPEND}
"

src_unpack() {
	unpack ${A}
	cd "${WORKDIR}"
	mv "${PN}-master" "${P}"
	mv "${PN}-ThirdParty-master" "${PN}-ThirdParty"
}

src_configure() {
	# xpdf ThirdParty build is the only one needed to make OpenBoard 
	cd ../OpenBoard-ThirdParty/xpdf/xpdf-3.04
	econf
}

src_compile() {
	cd ../OpenBoard-ThirdParty/xpdf
	eqmake5 xpdf.pro -spec linux-g++
	emake
	cd "${S}"
	eqmake5 OpenBoard.pro -spec linux-g++
	emake
}

pkg_preinst() {
	xdg_pkg_preinst
}

src_install() {
	if [[ -f Makefile ]] || [[ -f GNUmakefile ]] || [[ -f makefile ]] ; then
		emake DESTDIR="${D}" install
	fi
	einstalldocs

	P_INSTALL_PATH="/usr/lib/${PN}"
	PRODUCT_DIR="${S}/build/linux/release/product/"
	EXE="${P_INSTALL_PATH}/${PN}"
	exeinto "${P_INSTALL_PATH}"
	doexe "${PRODUCT_DIR}/${PN}"
	insinto "${P_INSTALL_PATH}"
	doins -r "${PRODUCT_DIR}/library" "${PRODUCT_DIR}/etc"
	dosym "${D}${EXE}" "/usr/bin/${PN}"

	# icon from: https://www.file-extensions.org/imgs/app-picture/11685/open-sankore.jpg
	#doicon "${S}/ubz-icon/ubz.png"
	ICON_DIR="${S}/resources/images"
	doicon --size 64 "${ICON_DIR}/OpenBoard.png"
	make_desktop_entry OpenBoard "openboard" "OpenBoard" "Utility"
	mv "${D}/usr/share/applications/OpenBoard-OpenBoard.desktop" "${D}/usr/share/applications/OpenBoard.desktop"
	echo "MimeType=application/ubz" >> "${D}/usr/share/applications/OpenBoard.desktop"
	mv "${ICON_DIR}/bigOpenBoard.png" "${ICON_DIR}/OpenBoard.png"
	doicon --size 512 "${ICON_DIR}/OpenBoard.png"

	dodir "/usr/share/mime/packages/"
	sed '/Document OpenBoard/i\    <icon name="ubz"/>' "${S}/resources/linux/openboard-ubz.xml" > "${D}/usr/share/mime/packages/openboard-ubz.xml"
}

pkg_postinst() {
	xdg_pkg_postinst
}

pkg_postrm() {
	xdg_pkg_postrm
}
