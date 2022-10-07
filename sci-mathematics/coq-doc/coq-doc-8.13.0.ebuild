# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit desktop multilib

MY_PV=${PV/_p/pl}
MY_P=${PN%%-doc}-${MY_PV}

DESCRIPTION="Proof assistant written in O'Caml"
HOMEPAGE="http://coq.inria.fr/"
SRC_URI="https://github.com/coq/coq/archive/V${MY_PV}.tar.gz -> ${PN%%-doc}-${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="+ocamlopt"

RDEPEND="
	>=dev-lang/ocaml-4.11.0:=[ocamlopt?]
	dev-ml/camlp5:=[ocamlopt?]
	dev-ml/num:="
DEPEND="${RDEPEND}	
	dev-python/sphinx_rtd_theme
	dev-python/beautifulsoup4
	dev-ml/findlib
	media-libs/netpbm[png,zlib]
	virtual/latex-base
	dev-tex/hevea
	dev-texlive/texlive-latexrecommended
	dev-texlive/texlive-pictures
	dev-texlive/texlive-mathscience
	dev-texlive/texlive-latexextra
	dev-python/pybtex-docutils
	>=dev-python/antlr4-python3-runtime-4.7.2
"

BDEPEND="dev-python/sphinxcontrib-bibtex"

S=${WORKDIR}/${MY_P}

src_configure() {
	ocaml_lib=$(ocamlc -where)
	local myconf=(
		-prefix /usr
		-bindir /usr/bin
		-libdir /usr/$(get_libdir)/coq
		-mandir /usr/share/man
		-coqdocdir /usr/$(get_libdir)/coq/coqdoc
		-docdir /usr/share/doc/${PF}
		-configdir /etc/xdg/${PN}
		)

	export CAML_LD_LIBRARY_PATH="${S}/kernel/byterun/"
	./configure ${myconf[@]} || die "configure failed"
}

src_compile() {
	emake SPHINXWARNERROR=0 doc-html
}

src_install() {
	emake COQINSTALLPREFIX="${D}" SPHINXWARNERROR=0 install-doc-html
}
