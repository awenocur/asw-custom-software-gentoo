# Copyright 2020 Adam Wenocur
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils

DESCRIPTION="script to augment my PulseAudio config"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

RDEPEND="media-sound/pulseaudio"
DEPEND="${RDEPEND}"

S=${WORKDIR}

src_install() {
	mkdir -p ${D}/usr/share/pulseaudio/alsa-mixer/profile-sets/
	mkdir -p ${D}/lib/udev/rules.d/
	cp ${FILESDIR}/custom.conf ${D}/usr/share/pulseaudio/alsa-mixer/profile-sets/
	cp ${FILESDIR}/91-pulseaudio-custom.rules ${D}/lib/udev/rules.d/
	default
}
