# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="A library with common code used by libraries and tools around the libimobiledevice project"
HOMEPAGE="https://www.libimobiledevice.org/"
SRC_URI="https://github.com/libimobiledevice/libimobiledevice-glue/releases/download/${PV}/${P}.tar.bz2"

RDEPEND="
	>=app-pda/libplist-2.3.0:=
	"

LICENSE="GPL-2+ LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 ~arm arm64 ppc ~ppc64 ~riscv x86"


BUILD_DIR="${S}_build"

src_prepare() {
	default
	eautoreconf
}

