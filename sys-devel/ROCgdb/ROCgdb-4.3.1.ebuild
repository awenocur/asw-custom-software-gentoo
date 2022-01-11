# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
SLOT=0

inherit autotools git-r3

EGIT_REPO_URI=${PN}
EGIT_COMMIT=rocm-${PV}
EVCS_OFFLINE=T

KEYWORDS='amd64 arm64 ppc64'

src_configure()
{
	econf --prefix=/usr/lib/ROCgdb
}