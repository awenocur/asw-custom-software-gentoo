# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="7"

inherit autotools

EGIT_COMMIT="c7b488fbf2a9ab95e451df1319e68662fff7b9b7"

DESCRIPTION="iRecovery is a libusb-based commandline utility to talk to iBoot/iBSS in Apple's iPhone/iPod touch via USB"
HOMEPAGE="https://github.com/libimobiledevice/libirecovery"
SRC_URI="https://github.com/libimobiledevice/${PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${EGIT_COMMIT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="virtual/libusb:1
        sys-libs/readline
	>=app-pda/libplist-2.3.0"
RDEPEND="${DEPEND}"

src_prepare() {
	echo "${PV}" > ${S}/.tarball-version
	default
	eautoreconf
}
