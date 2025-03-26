# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
SLOT=0
BDEPEND="dev-python/sphinx-rtd-theme"

inherit git-r3

EGIT_REPO_URI=${PN}
EGIT_COMMIT=6a6bc30bad35cf5c9d15177028a1d23230b10d48
EVCS_OFFLINE=T
KEYWORDS='amd64 x86 arm64'

src_compile()
{
	make qthelp
}

src_install()
{
	mkdir -p ${D}/var/www/localhost/htdocs/
	mv build/qthelp ${D}/var/www/localhost/htdocs/digikam
}