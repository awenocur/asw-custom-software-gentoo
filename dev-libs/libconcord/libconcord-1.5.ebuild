# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8
DISTUTILS_OPTIONAL=1
PYTHON_COMPAT=( python3_{9,10} )

inherit distutils-r1 autotools

MY_PN="concordance"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Library for programming Logitech Harmony universal remote controls"
HOMEPAGE="http://phildev.net/concordance/"
SRC_URI="https://github.com/jaymzh/concordance/archive/v${PV}.zip -> concordance-${PV}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="debug +udev -consolekit perl +python +usbnet-headers"

RDEPEND="virtual/libusb:0
dev-libs/hidapi
dev-libs/libzip
udev? ( virtual/udev )
consolekit? ( sys-auth/consolekit )
python? ( ${PYTHON_DEPS} )
"
DEPEND="${DEPEND}
perl? (
	dev-perl/Module-Build
	dev-lang/swig )
"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

S="${WORKDIR}/${MY_P}/${PN}"

src_prepare() {
	default
	if ! use usbnet-headers; then
		epatch "${FILESDIR}"/usbnet_headers_remove.patch
	fi
	mkdir m4
	eautoreconf --install
}

src_configure() {
	myconf="--prefix=/usr"

	if use debug; then
		myconf="${myconf} CPPFLAGS=-D_DEBUG"
	fi

	econf ${myconf}
}

src_compile() {
	emake

	if use udev; then
		emake udev
	elif use consolekit; then
		emake consolekit
	fi

	if use perl; then
		cd "${S}/bindings/perl"
		swig -perl5 concord.i
		perl-app_src_configure
	fi

	if use python; then
		cd "${S}/bindings/python"
		distutils-r1_src_compile
	fi
}

src_install() {
	dodoc ../{Changelog,CodingStyle,TODO,SubmittingPatches} README
	insinto /usr/share/doc/${P}/specs
	doins ../specs/*

	emake DESTDIR="${D}" install

	if use udev; then
		emake DESTDIR="${D}" install_udev
	elif use consolekit; then
		emake DESTDIR="${D}" install_consolekit
	fi

	if use perl; then
		cd "${S}/bindings/perl"
		emake DESTDIR="${D}" install
		cd ../..
	fi

	if use python; then
		cd "${S}/bindings/python"
		distutils-r1_src_install
	fi
}
