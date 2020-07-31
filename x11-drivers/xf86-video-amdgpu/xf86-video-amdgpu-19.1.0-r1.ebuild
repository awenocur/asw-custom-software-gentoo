# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
XORG_DRI="always"
inherit xorg-3

SRC_URI="https://gitlab.freedesktop.org/awenocur/xf86-video-amdgpu/-/archive/custom-commit-2020-07/xf86-video-amdgpu-custom-commit-2020-07.zip"

S=${WORKDIR}/xf86-video-amdgpu-custom-commit-2020-07

KEYWORDS="~amd64 ~ppc64 x86"

DESCRIPTION="Accelerated Open Source driver for AMDGPU cards"

IUSE="udev"

RDEPEND=">=x11-libs/libdrm-2.4.89[video_cards_amdgpu]
	x11-base/xorg-server[-minimal]
	udev? ( virtual/libudev:= )"
DEPEND="${RDEPEND}"

pkg_setup() {
	XORG_CONFIGURE_OPTIONS=(
		--enable-glamor
		$(use_enable udev)
	)
}

src_prepare() {
echo "Adam was here"
default
eautoreconf
}
