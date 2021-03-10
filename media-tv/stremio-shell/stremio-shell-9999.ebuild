# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Watch videos, movies, TV series and TV channels instantly. (Beta Version)"
HOMEPAGE="https://www.stremio.com"

inherit desktop qmake-utils git-r3
EGIT_REPO_URI="https://github.com/Stremio/stremio-shell.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="
	net-misc/wget
	net-libs/nodejs
	media-video/ffmpeg
	dev-qt/qtcore:5
	dev-qt/qtnetwork:5
	dev-qt/qtgui:5
	dev-qt/qtwebengine:5
	dev-qt/qtwidgets:5
	dev-qt/qtwebchannel:5
	dev-qt/qtdeclarative:5
	dev-qt/qtquickcontrols:5
	dev-qt/qtquickcontrols2:5
	dev-qt/qttranslations:5
	media-video/mpv[libmpv]
	dev-libs/openssl
"
RDEPEND="${DEPEND}"
BDEPEND=""

#S=$WORKDIR/stremio-shell-$PV

src_prepare() {
	eapply "${FILESDIR}/makefile.patch"
	eapply_user
}

src_configure() {
	eqmake5
}

src_compile() {
	emake
}

src_install() {
	emake INSTALL_ROOT="$D" DESTDIR="${D}" install
	dosym /opt/stremio/smartcode-stremio.desktop /usr/share/applications/smartcode-stremio.desktop
	dosym /opt/stremio/stremio /opt/bin/stremio
	dosym /usr/bin/node /opt/stremio/node
	doicon "${FILESDIR}"/smartcode-stremio.png
	insinto /opt/stremio/
		doins "${FILESDIR}"/server.js
		doins "${FILESDIR}"/stremio.asar

}
