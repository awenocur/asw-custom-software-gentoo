# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
SLOT=0


inherit cmake git-r3

EGIT_REPO_URI=${PN}
EGIT_COMMIT=321dae0006c827411111871cc3bd2aec64055315
EVCS_OFFLINE=T
KEYWORDS='amd64 x86 arm64'

src_install()
{
	cmake_src_install
	mv ${D}/usr/share/doc/HTML/* ${D}/usr/share/help
	rmdir ${D}/usr/share/doc/HTML
}