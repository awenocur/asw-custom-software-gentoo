EAPI=7

SLOT=0

inherit meson

KEYWORDS="amd64"

DESCRIPTION="The Kiwix library provides the Kiwix software
suite core. It contains the code shared by all Kiwix ports (Windows,
GNU/Linux, macOS, Android, iOS, ...)."

SRC_URI="https://github.com/kiwix/${PN}/archive/${PV}.zip -> ${P}.zip"

DEPEND="dev-libs/pugixml
dev-cpp/Mustache
dev-cpp/libzim
app-arch/xz-utils
dev-libs/icu
app-arch/zstd
sys-apps/util-linux
net-misc/curl
net-libs/libmicrohttpd
"

RDEPEND="net-misc/aria2"
