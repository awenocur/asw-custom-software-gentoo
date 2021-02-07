# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake

DESCRIPTION="Mustache implementation for modern C++ (requires C++11)"
HOMEPAGE="https://github.com/kainjow/Mustache"
SRC_URI="https://github.com/kainjow/Mustache/archive/v${PV}.zip -> ${P}.zip"

LICENSE="Boost-1.0"
SLOT="0"
KEYWORDS="amd64"

CMAKE_MAKEFILE_GENERATOR=emake

IUSE=""

CMAKE_BUILD_TYPE="release"

src_install()
{
	mkdir -p ${ED}/usr/include
	cp ${S}/mustache.hpp ${ED}/usr/include
}