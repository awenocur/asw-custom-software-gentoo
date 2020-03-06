# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools

DESCRIPTION="Program a Logitech Harmony universal remote controls"
HOMEPAGE="http://phildev.net/concordance/"
SRC_URI="https://github.com/jaymzh/concordance/archive/v${PV}.zip -> concordance-${PV}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-libs/libconcord"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}/${PN}"

src_prepare(){
	default
	mkdir m4
	eautoreconf --install
}