EAPI=7

SLOT=0

inherit meson

KEYWORDS="amd64"

DESCRIPTION="The ZIM library is the reference implementation for the ZIM file format. It's a solution to read and write ZIM files on many systems and architectures. More information about the ZIM format and the openZIM project at https://openzim.org/."

SRC_URI="https://github.com/openzim/libzim/archive/${PV}.zip -> ${P}.zip"

DEPEND="app-arch/xz-utils
dev-libs/icu
app-arch/zstd
sys-apps/util-linux
"
