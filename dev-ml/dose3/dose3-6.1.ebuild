# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Library to perform analysis on package repositories"
HOMEPAGE="http://www.mancoosi.org/software/ https://gforge.inria.fr/projects/dose"
SRC_URI="https://gitlab.com/irill/${PN}/-/archive/${PV}/${P}.tar.gz"
S="${WORKDIR}/${PN}-$(ver_cut 1-3)"

LICENSE="LGPL-3"
SLOT="0/${PV}"
KEYWORDS="amd64 arm arm64 ppc ppc64 x86"
IUSE="+ocamlopt +parmap +zip +bzip2 xml curl rpm4 +test"

BDEPEND="
	dev-ml/cppo
	dev-ml/findlib
	dev-ml/ocamlbuild
"
RDEPEND="
	>=dev-lang/ocaml-4.03:=[ocamlopt=]
	>=dev-ml/dune-2.7
	>=dev-ml/ocaml-base64-3.5.0:=[ocamlopt=]
	dev-ml/cudf:=[ocamlopt=]
	>=dev-ml/extlib-1.7.8:=[ocamlopt=]
	>=dev-ml/ocamlgraph-2.0.0:=[ocamlopt=]
	>=dev-ml/re-1.2.2:=[ocamlopt=]
	parmap? ( dev-ml/parmap:=[ocamlopt=] )
	zip? ( dev-ml/camlzip:=[ocamlopt=] )
	bzip2? ( dev-ml/camlbz2:= )
	xml? (
		dev-ml/ocaml-expat:=[ocamlopt=]
		dev-ml/xml-light:=[ocamlopt=]
	)
	curl? ( dev-ml/ocurl:= )
	rpm4? ( app-arch/rpm )
"
DEPEND="${RDEPEND}
	test? ( dev-python/pyyaml[libyaml]
	      	dev-ml/ounit2
		)
"

# missing test data
#RESTRICT="test"

QA_FLAGS_IGNORED='.*'

src_prepare() {
	default
	sed -e 's/INSTALL_STUFF_ +=/INSTALL_STUFF_ =/' -i Makefile || die
	sed -e 's/installlib: META installcudf/installlib:/' -i Makefile || die
	sed -e 's/_build\/applications/_build\/install\/default\/bin/' -i Makefile || die
	sed -e 's/^.*\/distcheck .*BINDIR)\/.*EXE.*$//' -i Makefile || die
	rm -R ${S}/src/*/tests
	rm -R ${S}/tests
}

src_configure() {
	econf \
		$(use ocamlopt || echo "--with-bytecodeonly") \
		$(use parmap && echo "--with-parmap") \
		$(use zip && echo "--with-zip") \
		$(use bzip2 && echo "--with-bz2") \
		$(use xml && echo "--with-xml") \
		$(use curl && echo "--with-curl") \
		$(use rpm4 && echo "--with-rpm4")
}

src_compile() {
	emake -j1 LIBDIR=${ED}/usr/lib VERBOSE="-classic-display"
}

src_install() {
	emake DESTDIR="${D}" BINDIR="${ED}/usr/bin" LIBDIR=${ED}/usr/lib install || die
	dodoc CHANGES CREDITS README.architecture TODO
}
