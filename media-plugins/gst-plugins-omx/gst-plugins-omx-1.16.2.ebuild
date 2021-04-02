# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gst-plugins-libav/gst-plugins-libav-1.2.0.ebuild,v 1.3 2014/01/21 21:56:59 eva Exp $

EAPI="6"

inherit flag-o-matic multilib-minimal eutils

MY_PN="gst-omx"
DESCRIPTION="GStreamer OpenMAX IL wrapper plugin"
HOMEPAGE="http://gstreamer.freedesktop.org/modules/gst-omx.html"
SRC_URI="http://gstreamer.freedesktop.org/src/${MY_PN}/${MY_PN}-${PV}.tar.xz"

LICENSE="LGPL-2.1"
SLOT="1.0"
KEYWORDS="amd64 ~arm"
IUSE="rpi +tizonia"

GST_REQ="${PV}"

# FIXME: What >=media-libs/gst-plugins-bad-1.4.0:1.0[gl] stuff for non-rpi?
RDEPEND="
	>=media-libs/gstreamer-${GST_REQ}:${SLOT}[${MULTILIB_USEDEP}]
	>=media-libs/gst-plugins-base-${GST_REQ}:${SLOT}[${MULTILIB_USEDEP}]
	rpi? (
		media-libs/raspberrypi-userland
		>=media-libs/gst-plugins-bad-${GST_REQ}:${SLOT}[${MULTILIB_USEDEP}]
	)
	tizonia? ( media-sound/tizonia )
"
DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1.3
	virtual/pkgconfig
"

S="${WORKDIR}/${MY_PN}-${PV}"

src_configure() {
	GST_PLUGINS_BUILD=""
	local myconf
	if use rpi; then
		myconf="${myconf} --with-omx-target=rpi --with-omx-header-path=/opt/vc/include/IL"
	fi
	if use tizonia; then
		myconf="${myconf} --with-omx-target=tizonia"
	fi
	econf \
		--disable-maintainer-mode \
		--with-package-name="Gentoo GStreamer ebuild" \
		--with-package-origin="http://www.gentoo.org" \
		${myconf}
}

src_compile() {
	default
}

src_install() {
	DOCS="AUTHORS ChangeLog NEWS README RELEASE"
	default
	prune_libtool_files --modules
}
