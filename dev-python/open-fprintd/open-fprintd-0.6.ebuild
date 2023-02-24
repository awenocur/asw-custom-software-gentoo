EAPI=7
PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

RDEPEND=">=dev-python/cryptography-2.1.4
	>=dev-python/pyusb-1.0.0
	>=dev-python/pyyaml-3.12
	app-arch/innoextract
"

python_install() {
	distutils-r1_python_install
	mkdir -p ${ED}/usr/share/dbus-1/services
	mkdir -p ${ED}/lib/systemd/system
	cp -pR ${WORKDIR}/${P}/debian/open-fprintd-*.service ${ED}/usr/share/dbus-1/services
	cp -pR ${WORKDIR}/${P}/debian/open-fprintd.service ${ED}/lib/systemd/system
	
}

KEYWORDS="~alpha amd64 ~arm ~arm64 ~hppa ~ia64 ppc ppc64 sparc x86 ~x86-solaris"
SRC_URI="https://github.com/uunicorn/open-fprintd/archive/refs/tags/${PV}.zip -> ${P}.zip"
DESCRIPTION="Fprintd replacement which allows you to have your own backend as a standalone service."
HOMEPAGE="https://github.com/uunicorn/python-validity"
LICENSE="MIT"

SLOT="0"
