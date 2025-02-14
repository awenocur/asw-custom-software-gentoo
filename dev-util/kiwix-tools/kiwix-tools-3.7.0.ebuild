EAPI=7

SLOT=0

inherit meson

KEYWORDS="amd64"
LICENSE="GPL-3"

DESCRIPTION="The Kiwix tools is a collection of Kiwix related command line tools."

SRC_URI="https://github.com/kiwix/${PN}/archive/${PV}.zip -> ${P}.zip"

DEPEND="dev-cpp/libkiwix
	net-libs/libmicrohttpd"

