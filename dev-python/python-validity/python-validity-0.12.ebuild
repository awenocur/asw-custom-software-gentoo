EAPI=7
PYTHON_COMPAT=( python3_{8..9} )

inherit distutils-r1

RDEPEND=">=dev-python/cryptography-2.1.4
	>=dev-python/pyusb-1.0.0
	>=dev-python/pyyaml-3.12
	app-arch/innoextract
"
python_install() {
	distutils-r1_python_install
	mkdir -p ${ED}/lib/systemd/system
	mkdir -p ${ED}/lib/udev/rules.d
	cp -p ${WORKDIR}/${P}/debian/python3-validity.service ${ED}/lib/systemd/system
	cp -p ${FILESDIR}/kill-python3-validity.service ${ED}/lib/systemd/system
	cp -p ${WORKDIR}/${P}/debian/python3-validity.udev ${ED}/lib/udev/rules.d/80-python-validity.rules
}

KEYWORDS="~alpha amd64 ~arm ~arm64 ~hppa ~ia64 ppc ppc64 sparc x86 ~x86-solaris"
SRC_URI="https://github.com/uunicorn/python-validity/archive/refs/tags/${PV}.zip -> ${P}.zip"
DESCRIPTION="Validity fingerprint sensor driver."
HOMEPAGE="https://github.com/uunicorn/python-validity"
LICENSE="MIT"

SLOT="0"
