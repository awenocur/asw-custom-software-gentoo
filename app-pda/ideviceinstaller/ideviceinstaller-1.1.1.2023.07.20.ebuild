# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
inherit autotools flag-o-matic

EGIT_COMMIT="b9cfe0b264f66eab9ad88e11eb6b0523cb1de911"

DESCRIPTION="A tool to interact with the installation_proxy of an Apple's iDevice"
HOMEPAGE="http://www.libimobiledevice.org/"
SRC_URI="https://github.com/libimobiledevice/${PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${EGIT_COMMIT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND=">=app-pda/libimobiledevice-1.3.0:=
	>=app-pda/libplist-2.3:=
	>=dev-libs/libzip-0.8"
DEPEND="${RDEPEND}"
BDEPEND="virtual/pkgconfig"

src_prepare() {
	echo "${PV}" > ${S}/.tarball-version
	default
	eautoreconf
}
