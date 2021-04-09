# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{6..9} )

inherit distutils-r1

DESCRIPTION="Better dates and times for Python"
HOMEPAGE="https://github.com/crsmithdev/arrow/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

SLOT=3

KEYWORDS="amd64 ~arm64 x86"

DEPEND=">=dev-python/cython-0.29
	>=dev-python/numpy-1.14
	dev-cpp/arrow
	dev-util/cmake"
