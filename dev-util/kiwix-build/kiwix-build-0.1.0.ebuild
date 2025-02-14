
# Copyright 2016-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_{10,11,12} )
DISTUTILS_USE_SETUPTOOLS="rdepend"

KIWIX_REVISION="r_58"

SRC_URI="https://github.com/kiwix/${PN}/archive/${KIWIX_REVISION}.zip -> ${P}.zip"
S=${WORKDIR}/${PN}-${KIWIX_REVISION}
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~m68k ~mips ppc ppc64 ~riscv s390 sparc x86 ~x64-cygwin ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"

inherit distutils-r1 toolchain-funcs

DESCRIPTION="build system for Kiwix"
HOMEPAGE="https://github.com/kiwix/kiwix-build/"

LICENSE="GPL-3"
SLOT="0"

DEPEND="
	>=dev-build/ninja-1.6
	>=dev-build/meson-0.34
"
