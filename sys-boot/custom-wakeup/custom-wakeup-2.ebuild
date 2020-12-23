# Copyright 2020 Adam Wenocur
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils

DESCRIPTION="script to fix my fans and HDDs"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="sys-apps/systemd"
DEPEND="${RDEPEND}"

S=${WORKDIR}

src_install() {
	mkdir -p ${D}/usr/libexec
	mkdir -p ${D}/lib/systemd/system
	cp ${FILESDIR}/fix_fans.sh ${D}/usr/libexec
	cp ${FILESDIR}/set_fans.service ${D}/lib/systemd/system
	default
}