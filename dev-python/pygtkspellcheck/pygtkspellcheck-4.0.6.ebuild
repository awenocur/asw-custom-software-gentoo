# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_8 python3_9 )

inherit distutils-r1

DESCRIPTION="A simple but quite powerful spellchecking library written in pure Python for Gtk based on Enchant."
HOMEPAGE="https://github.com/koehlma/pygtkspellcheck"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 ~m68k ~mips ppc ppc64 s390 sparc x86 ~x64-cygwin ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

BDEPEND="dev-python/setuptools[${PYTHON_USEDEP}]"
DEPEND="app-text/gtkspell dev-python/pygobject dev-python/pyenchant"
