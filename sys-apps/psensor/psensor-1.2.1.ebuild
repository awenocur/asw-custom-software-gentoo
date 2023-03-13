# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit gnome2-utils xdg-utils git-r3 autotools

DESCRIPTION="A graphical hardware temperature monitor"
HOMEPAGE="https://wpitchoune.net/psensor/"

EGIT_REPO_URI="https://gitlab.com/jeanfi/psensor.git"
EGIT_COMMIT="7e4173d54bc3ddf63d15d33ac2f096f1abaf0ca7"

KEYWORDS="amd64 ~x86"
LICENSE="GPL-2"
SLOT="0"
IUSE="+gtop +hddtemp nls +server +udisks X"

RDEPEND="
	>=dev-libs/json-c-0.11.99
	dev-libs/glib:2
	dev-libs/libatasmart
	gnome-base/dconf
	gtop? ( >=gnome-base/libgtop-2.0:2 )
	hddtemp? ( app-admin/hddtemp )
	net-misc/curl
	server? ( net-libs/libmicrohttpd )
	sys-apps/lm-sensors
	udisks? ( sys-fs/udisks:2 )
	X? (
		>=x11-libs/gtk+-3.4:3
		x11-libs/libnotify
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/cairo
	)"

DEPEND="${RDEPEND}
	app-text/asciidoc
	sys-apps/help2man
	nls? ( sys-devel/gettext )"

src_prepare() {
	eapply_user
}

src_configure() {
	local econfargs=(
		$(use_with gtop)
		$(use_enable nls)
		$(use_with X x)
	)
	eautoreconf

	CFLAGS=-Wno-error=incompatible-pointer-types econf "${econfargs[@]}" || die
}

pkg_preinst() {
	gnome2_schemas_savelist
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_schemas_update
	gnome2_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	gnome2_schemas_update
}
