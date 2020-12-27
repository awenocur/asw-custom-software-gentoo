# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson pam systemd

DESCRIPTION="D-Bus service to access fingerprint readers"
HOMEPAGE="https://cgit.freedesktop.org/libfprint/fprintd/"
SRC_URI="https://gitlab.freedesktop.org/libfprint/fprintd/-/archive/v${PV}/fprintd-v1.90.7.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 arm ~arm64 ~ia64 ppc ppc64 sparc x86"
IUSE="doc pam"

RDEPEND="
	dev-libs/dbus-glib
	dev-libs/glib:2
	>=sys-auth/libfprint-1.90
	sys-auth/polkit
	pam? ( sys-libs/pam 
	       sys-libs/pam_wrapper
	       dev-python/dbusmock )
"
DEPEND="${RDEPEND}
	dev-util/gtk-doc
	dev-util/gtk-doc-am
	dev-util/intltool
	doc? ( dev-libs/libxml2 dev-libs/libxslt )
"

S=${WORKDIR}/${PN}-v${PV}

src_configure() {
		local emesonargs=(
	      	      -Dpam=$(usex pam true false)
	      	      -Dsystemd_system_unit_dir=$(systemd_get_systemunitdir)
	      	      -Dgtk_doc=$(usex doc true false)
		)
		meson_src_configure
}

src_install() {

	keepdir /var/lib/fprint

	find "${D}" -name "*.la" -delete || die

	dodoc AUTHORS NEWS README{,.transifex} TODO
	newdoc pam/README README.pam_fprintd
	if use doc ; then
		insinto /usr/share/doc/${PF}/html
		doins doc/{fprintd-docs,version}.xml
		insinto /usr/share/doc/${PF}/html/dbus
		doins doc/dbus/net.reactivated.Fprint.{Device,Manager}.ref.xml
	fi
	meson_src_install
}

pkg_postinst() {
	elog "Please take a look at README.pam_fprintd for integration docs."
}
