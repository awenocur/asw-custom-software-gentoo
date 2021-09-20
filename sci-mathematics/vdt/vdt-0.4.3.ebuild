# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="The vdt mathematical library"
HOMEPAGE="http://lcginfo.cern.ch/pkgver/vdt/${PV}"
SRC_URI="https://github.com/dpiparo/${PN}/archive/v${PV}.zip -> ${P}.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 x86"


src_install() {
	cmake_src_install
	mv ${ED}/usr/lib ${ED}/usr/$(get_libdir)
}
