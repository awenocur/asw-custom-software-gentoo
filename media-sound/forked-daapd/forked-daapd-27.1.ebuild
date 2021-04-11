# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

# TODO:
# Add --enable-spotify when it works

EAPI=5

inherit autotools eutils user

DESCRIPTION="A DAAP (iTunes) media server"
HOMEPAGE="https://github.com/ejurgensen/forked-daapd"
SRC_URI="https://github.com/ejurgensen/forked-daapd/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE="alsa itunes lastfm mpd webinterface"

# Note: mpd support appears to be standalone, e.g. --enable-mpd doesn't
# result in additional linkage.
RDEPEND="
	dev-db/sqlite:3
	dev-libs/antlr-c:0
	dev-libs/confuse
	dev-libs/libevent
	dev-libs/libgcrypt:0
	dev-libs/libunistring
	>=dev-libs/mxml-2.9[threads]
	dev-libs/json-c
	media-libs/alsa-lib
	net-dns/avahi[dbus]
	media-video/ffmpeg

	itunes? ( app-pda/libplist )
	lastfm? ( net-misc/curl )
	webinterface? ( net-libs/libwebsockets )
"

DEPEND="
	dev-java/antlr:3.5
	${RDEPEND}
"

pkg_setup() {
	enewuser daapd
	enewgroup daapd
}

src_prepare() {
	eautoreconf
}

src_configure() {
	CFLAGS=$CFLAGS\ -fcommon \
	ac_cv_path_ANTLR=antlr3.5 \
	econf \
		--with-alsa \
		$(use_enable itunes) \
		$(use_enable lastfm) \
		$(use_enable mpd) \
		$(use_enable webinterface) \
		--disable-verification
}

src_install() {
	emake DESTDIR="${D}" install

	newinitd "${FILESDIR}/daapd.initd" daapd
	newconfd "${FILESDIR}/daapd.confd" daapd

	# dodir by itself fails in the likely case of /srv/music having a
	# volume mounted already.
	test -d /srv/music || dodir /srv/music

	fowners -R daapd:daapd /var/lib/cache/forked-daapd
}
