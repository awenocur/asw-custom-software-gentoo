EAPI=7

inherit xdg

SLOT="0"
LICENSE="GPL-3"

DESCRIPTION="viewer/manager of ZIM files"

SRC_URI="https://github.com/kiwix/${PN}/archive/${PV}.zip -> ${P}.zip"

KEYWORDS="amd64"

BDEPEND="dev-util/kiwix-build"

DEPEND="dev-cpp/kiwix-lib
	net-misc/aria2
	dev-qt/qtwebengine
	dev-qt/qtgui
	dev-qt/qtimageformats"

src_prepare() {
	      default
	      mkdir -p ${WORKDIR}/build/SOURCE/kiwix-desktop
	      mv ${S}/* ${WORKDIR}/build/SOURCE/kiwix-desktop
	      mv ${WORKDIR}/build/SOURCE ${S}
}

src_compile() {
	      kiwix-build --skip-source-prepare --build-nodeps --working-dir ${S} kiwix-desktop
}

src_install()
{
	mv ${S}/BUILD_native_dyn/INSTALL/* ${ED}
	mkdir -p ${ED}/usr
	mv ${ED}/share ${ED}/usr
	default
}

pkg_postinst()
{
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
}

pkg_postrm()
{
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
}
