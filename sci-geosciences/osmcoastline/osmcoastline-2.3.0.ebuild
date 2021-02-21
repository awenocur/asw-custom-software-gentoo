# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit cmake-utils

DESCRIPTION="Fast and flexible C++ library for working with OpenStreetMap data."
HOMEPAGE="https://github.com/osmcode/osmcoastline"
SRC_URI="https://github.com/osmcode/${PN}/archive/v${PV}.zip -> ${P}.zip"

LICENSE="Boost-1.0"
SLOT="0"
KEYWORDS=""
KEYWORDS="amd64"

IUSE="gdalcpp protozero utfcpp doc test"

RDEPEND="
    sys-libs/zlib
    dev-libs/expat
    app-arch/bzip2
    sci-libs/geos
    sci-libs/gdal[geos,threads]
    sci-libs/proj
    dev-cpp/sparsehash
    sci-geosciences/libosmium
    dev-cpp/protozero
    app-arch/lz4
    dev-libs/boost:=
"
DEPEND="${RDEPEND}
    doc? (
        app-doc/doxygen
        media-gfx/graphviz
    )
"

src_configure() {
    local mycmakeargs=(
        -DCMAKE_INSTALL_DOCDIR=share/doc/${P}

        $(cmake-utils_use gdalcpp   INSTALL_GDALCPP)
        $(cmake-utils_use protozero INSTALL_PROTOZERO)
        $(cmake-utils_use utfcpp    INSTALL_UTFCPP)

        $(cmake-utils_use doc  BUILD_DOC)
        $(cmake-utils_use test BUILD_TESTING)
    )
    cmake-utils_src_configure
}

src_compile() {
    cmake-utils_src_compile
    if use doc; then
        emake -C "${BUILD_DIR}" doc
    fi
}

src_test() {
    cmake-utils_src_test
}

src_install() {
    if ! use doc ; then
        rm "README.md"
    fi
    cmake-utils_src_install
}
